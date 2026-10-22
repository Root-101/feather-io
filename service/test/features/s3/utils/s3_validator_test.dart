import 'dart:io';

import 'package:service/feather.dart';
import 'package:test/test.dart';

void main() {
  group('S3Validator.isValidKey', () {
    test('Should accept keys and folders', () {
      for (final key in ['a', 'a/b.txt', 'photos/', 'photos/2026/', 'a.b/c d.txt']) {
        expect(S3Validator.isValidKey(key), isTrue, reason: key);
      }
    });

    test('Should accept ".." inside a name, which S3 allows', () {
      for (final key in ['informe..final.pdf', 'v1..2/x', '..hidden', 'a/..b']) {
        expect(S3Validator.isValidKey(key), isTrue, reason: key);
      }
    });

    test('Should reject ".." segments (path traversal)', () {
      for (final key in ['..', '../a', 'a/../b', 'a/..', '../../etc/passwd']) {
        expect(S3Validator.isValidKey(key), isFalse, reason: key);
      }
    });

    test('Should reject a name ending in a dot or a space on Windows only', () {
      // Windows drops them from a name: 'a.' would be the file 'a'
      for (final key in ['a.', 'b/c ', 'd./e', 'f..']) {
        expect(S3Validator.isValidKey(key), !Platform.isWindows, reason: key);
      }
    });

    test('Should reject empty or "." segments, another name for the same file', () {
      for (final key in ['a//b', 'a/./b', './a', '/a', 'a//', '//', 'a/.']) {
        expect(S3Validator.isValidKey(key), isFalse, reason: key);
      }
    });
  });
}
