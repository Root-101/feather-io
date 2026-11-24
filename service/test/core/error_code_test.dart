@TestOn('vm')
library;

import 'dart:io';

import 'package:service/feather.dart';
import 'package:test/test.dart';

/// The keys of a slang YAML file as dotted paths (`errors.sources.inUse`).
Set<String> keysOf(String path) {
  final keys = <String>{};
  final parents = <(int, String)>[];
  for (final line in File(path).readAsLinesSync()) {
    final match = RegExp(r'^( *)([A-Za-z0-9_]+)(?:\([^)]*\))?:')
        .firstMatch(line);
    if (match == null) continue;
    final indent = match[1]!.length;
    parents.removeWhere((p) => p.$1 >= indent);
    keys.add([...parents.map((p) => p.$2), match[2]!].join('.'));
    parents.add((indent, match[2]!));
  }
  return keys;
}

void main() {
  final locales = Directory('lib/i18n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.i18n.yaml'))
      .toList();

  test('Should have a message in every language for every error code', () {
    expect(locales, hasLength(greaterThanOrEqualTo(2)));
    for (final file in locales) {
      final keys = keysOf(file.path);
      for (final error in ErrorCode.values) {
        expect(
          keys,
          contains('errors.${error.code}'),
          reason: '${file.path}: ${error.name}',
        );
      }
    }
  });

  test('Should keep every code unique', () {
    final codes = ErrorCode.values.map((e) => e.code).toList();
    expect(codes.toSet(), hasLength(codes.length));
  });
}
