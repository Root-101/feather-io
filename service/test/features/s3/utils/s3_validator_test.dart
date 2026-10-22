import 'package:service/feather.dart';
import 'package:test/test.dart';

void main() {
  group('S3Validator.isValidKey', () {
    test('Should accept keys and folders', () {
      for (final key in ['a', 'a/b.txt', 'photos/', 'photos/2026/', 'a.b/c d.txt']) {
        expect(S3Validator.isValidKey(key), isTrue, reason: key);
      }
    });

    test('Should reject empty or "." segments, another name for the same file', () {
      for (final key in ['a//b', 'a/./b', './a', '/a', 'a//', '//', 'a/.']) {
        expect(S3Validator.isValidKey(key), isFalse, reason: key);
      }
    });
  });
}
