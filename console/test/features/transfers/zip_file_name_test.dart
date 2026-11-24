import 'package:console/app_exporter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransfersCubit.zipFileName', () {
    test('A given name gets .zip once', () {
      expect(
        TransfersCubit.zipFileName(['a', 'b'], zipName: 'books'),
        'books.zip',
      );
      expect(
        TransfersCubit.zipFileName(['a', 'b'], zipName: 'books.zip'),
        'books.zip',
      );
    });

    test('A single key names the zip after it (folder or object)', () {
      expect(TransfersCubit.zipFileName(['photos/2026/']), '2026.zip');
      expect(TransfersCubit.zipFileName(['docs/report.pdf']), 'report.pdf.zip');
    });

    test('Several keys without a name get a dated name', () {
      expect(
        TransfersCubit.zipFileName(['a.txt', 'b.txt']),
        matches(RegExp(r'^download_\d+\.zip$')),
      );
    });
  });
}
