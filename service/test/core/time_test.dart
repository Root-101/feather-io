import 'package:service/feather.dart';
import 'package:test/test.dart';

void main() {
  group('JsonDate', () {
    test('Should write a moment in UTC with milliseconds', () {
      expect(
        DateTime.utc(2026, 10, 30, 5, 16, 13, 373).toJsonDate(),
        '2026-10-30T05:16:13.373Z',
      );
      expect(DateTime.utc(2026, 1, 2).toJsonDate(), '2026-01-02T00:00:00.000Z');
    });

    test('Should drop the microseconds', () {
      expect(
        DateTime.utc(2026, 10, 30, 5, 16, 13, 373, 999).toJsonDate(),
        '2026-10-30T05:16:13.373Z',
      );
    });

    test('Should convert a local moment to UTC', () {
      final local = DateTime(2026, 10, 30, 5, 16, 13);
      expect(
        DateTime.parse(local.toJsonDate()).isAtSameMomentAs(local),
        isTrue,
      );
      expect(local.toJsonDate(), endsWith('Z'));
    });
  });

  test('Should give now in UTC', () => expect(utcNow().isUtc, isTrue));
}
