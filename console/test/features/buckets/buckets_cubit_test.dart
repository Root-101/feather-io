import 'package:bloc_test/bloc_test.dart';
import 'package:console/app_exporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../support/fixtures.dart';

class _MockRepo extends Mock implements BucketsRepo {}

class _MockAuth extends Mock implements AuthCubit {}

void main() {
  late _MockRepo repo;
  late _MockAuth auth;

  final media = bucket('media', objectCount: 3);
  final backups = bucket('backups');

  setUp(() {
    repo = _MockRepo();
    auth = _MockAuth();
    when(() => auth.auth).thenReturn(session());
    when(() => repo.listBuckets(token: any(named: 'token')))
        .thenAnswer((_) async => [media, backups]);
    when(
      () => repo.deleteBucket(
        name: any(named: 'name'),
        token: any(named: 'token'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => repo.emptyBucket(
        name: any(named: 'name'),
        token: any(named: 'token'),
      ),
    ).thenAnswer((_) async {});
  });

  BucketsCubit build() => BucketsCubit(repo, auth);

  List<String> names(BucketsState state) =>
      state.buckets.map((b) => b.name).toList();

  group('load', () {
    blocTest<BucketsCubit, BucketsState>(
      'Loads the buckets with the JWT of the session',
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<BucketsSearchingState>(),
        isA<BucketsSearchOkState>().having(names, 'buckets', [
          'media',
          'backups',
        ]),
      ],
      verify: (_) => verify(() => repo.listBuckets(token: 'jwt')).called(1),
    );

    blocTest<BucketsCubit, BucketsState>(
      'A failure keeps the buckets already shown',
      build: build,
      act: (cubit) async {
        await cubit.load();
        when(() => repo.listBuckets(token: any(named: 'token')))
            .thenThrow(apiError('down'));
        await cubit.load();
      },
      skip: 2,
      expect: () => [
        isA<BucketsSearchingState>().having(names, 'buckets', [
          'media',
          'backups',
        ]),
        isA<BucketsSearchErrorState>()
            .having((s) => s.exception.message, 'message', 'down')
            .having(names, 'buckets', ['media', 'backups']),
      ],
    );
  });

  group('actions', () {
    late List<BucketChangedEvent> events;

    blocTest<BucketsCubit, BucketsState>(
      'Deleting a bucket reloads the list and tells the other sections',
      build: build,
      act: (cubit) async {
        events = [];
        final other = GlobalEventBus().on<BucketChangedEvent>().listen(
          events.add,
        );
        await cubit.deleteBucket(bucket: backups);
        await busDelivered();
        await other.cancel();
      },
      expect: () => [
        isA<BucketsUpdatingState>(),
        // The screen showing it moves on to another bucket
        isA<BucketsUpdatedOkState>().having(
          (s) => s.deletedBucket,
          'deletedBucket',
          'backups',
        ),
        isA<BucketsSearchingState>(),
        isA<BucketsSearchOkState>(),
      ],
      verify: (cubit) {
        verify(() => repo.deleteBucket(name: 'backups', token: 'jwt'));
        verify(() => repo.listBuckets(token: 'jwt')).called(1);
        expect(events.single.change, BucketChange.deleted);
        expect(events.single.bucketName, 'backups');
        expect(events.single.source, same(cubit));
      },
    );

    blocTest<BucketsCubit, BucketsState>(
      'Emptying a bucket reloads the list',
      build: build,
      act: (cubit) => cubit.emptyBucket(bucket: media),
      expect: () => [
        isA<BucketsUpdatingState>(),
        isA<BucketsUpdatedOkState>().having(
          (s) => s.deletedBucket,
          'deletedBucket',
          isNull,
        ),
        isA<BucketsSearchingState>(),
        isA<BucketsSearchOkState>(),
      ],
      verify: (_) =>
          verify(() => repo.emptyBucket(name: 'media', token: 'jwt')),
    );

    blocTest<BucketsCubit, BucketsState>(
      'A failed action carries the message and reloads nothing',
      build: build,
      setUp: () => when(
        () => repo.deleteBucket(
          name: any(named: 'name'),
          token: any(named: 'token'),
        ),
      ).thenThrow(apiError('The bucket is not empty')),
      act: (cubit) => cubit.deleteBucket(bucket: media),
      expect: () => [
        isA<BucketsUpdatingState>(),
        isA<BucketsUpdatingErrorState>().having(
          (s) => s.message,
          'message',
          'The bucket is not empty',
        ),
      ],
      verify: (_) =>
          verifyNever(() => repo.listBuckets(token: any(named: 'token'))),
    );
  });

  group('changes from other sections', () {
    blocTest<BucketsCubit, BucketsState>(
      'Reloads when another cubit changes a bucket',
      build: build,
      act: (cubit) async {
        GlobalEventBus().fire(
          const BucketChangedEvent(
            source: Object(),
            change: BucketChange.created,
            bucketName: 'logs',
          ),
        );
        await busDelivered();
      },
      expect: () => [isA<BucketsSearchingState>(), isA<BucketsSearchOkState>()],
    );

    blocTest<BucketsCubit, BucketsState>(
      'Ignores its own changes (it already reloads by itself)',
      build: build,
      act: (cubit) async {
        GlobalEventBus().fire(
          BucketChangedEvent(
            source: cubit,
            change: BucketChange.created,
            bucketName: 'logs',
          ),
        );
        await busDelivered();
      },
      expect: () => const <BucketsState>[],
    );
  });
}
