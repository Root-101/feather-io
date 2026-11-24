import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketsCubit extends Cubit<BucketsState>
    with GlobalEventBusCommunication<BucketsState> {
  final BucketsRepo _repo;
  final AuthCubit _auth;

  BucketsCubit(this._repo, this._auth) : super(const BucketsInitialState()) {
    // each section (browser, Buckets) has its own BucketsCubit: if another one
    // changes the buckets, this one reloads its list
    onBus<BucketChangedEvent>((event) {
      if (!identical(event.source, this)) load();
    });
  }

  /// Reloads the list after a change made from this section and notifies the
  /// others (the other bucket lists and the browser)
  Future<void> reloadAfterChange({
    required BucketChange change,
    required String bucketName,
    BucketModel? bucket,
  }) async {
    GlobalEventBus().fire(
      BucketChangedEvent(
        source: this,
        change: change,
        bucketName: bucketName,
        bucket: bucket,
      ),
    );
    await load();
  }

  Future<void> load() async {
    emit(BucketsSearchingState(buckets: state.buckets));
    try {
      final buckets = await _repo.listBuckets(token: _auth.auth?.accessToken);
      emit(BucketsSearchOkState(buckets: buckets));
    } catch (e) {
      emit(
        BucketsSearchErrorState(
          ExceptionConverter.parse(e),
          buckets: state.buckets,
        ),
      );
    }
  }

  Future<void> deleteBucket({required BucketModel bucket}) async {
    await _process(
      bucket: bucket,
      change: BucketChange.deleted,
      deleted: true,
      () =>
          _repo.deleteBucket(name: bucket.name, token: _auth.auth?.accessToken),
    );
  }

  Future<void> emptyBucket({required BucketModel bucket}) async {
    await _process(
      bucket: bucket,
      change: BucketChange.emptied,
      () =>
          _repo.emptyBucket(name: bucket.name, token: _auth.auth?.accessToken),
    );
  }

  /// Runs an action on the buckets and, if it succeeds, reloads the list
  Future<void> _process(
    Future<void> Function() action, {
    required BucketModel bucket,
    required BucketChange change,
    bool deleted = false,
  }) async {
    emit(BucketsUpdatingState(buckets: state.buckets));
    try {
      await action();
      emit(
        BucketsUpdatedOkState(
          buckets: state.buckets,
          deletedBucket: deleted ? bucket.name : null,
        ),
      );
    } catch (e) {
      emit(
        BucketsUpdatingErrorState(
          ExceptionConverter.parse(e).intlMessage,
          buckets: state.buckets,
        ),
      );
      return;
    }
    await reloadAfterChange(change: change, bucketName: bucket.name);
  }
}

abstract class BucketsState {
  final List<BucketModel> buckets;

  const BucketsState({this.buckets = const []});
}

final class BucketsInitialState extends BucketsState {
  const BucketsInitialState();
}

//------------------------- LOADING -------------------------\\
final class BucketsSearchingState extends BucketsState {
  const BucketsSearchingState({super.buckets});
}

final class BucketsSearchOkState extends BucketsState {
  const BucketsSearchOkState({super.buckets});
}

final class BucketsSearchErrorState extends BucketsState {
  final GlobalException exception;

  const BucketsSearchErrorState(this.exception, {super.buckets});
}

//------------------------- PROCESSING -------------------------\\
final class BucketsUpdatingState extends BucketsState {
  const BucketsUpdatingState({super.buckets});
}

final class BucketsUpdatedOkState extends BucketsState {
  /// The bucket the action deleted, so a screen showing it can move on
  final String? deletedBucket;

  const BucketsUpdatedOkState({super.buckets, this.deletedBucket});
}

final class BucketsUpdatingErrorState extends BucketsState {
  final String message;

  const BucketsUpdatingErrorState(this.message, {super.buckets});
}
