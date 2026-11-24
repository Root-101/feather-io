import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:service/feather.dart';
import 'package:sqlite3/sqlite3.dart' show Database;

part 'database.g.dart';

// Generate the code with: fvm dart run build_runner build

@DriftDatabase(
  tables: [
    AccessKeyGrantTable,
    AccessKeyTable,
    AnonymousRuleTable,
    BucketTable,
    ObjectMetaTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  /// For the health check: true when SQLite answers a query (it throws
  /// otherwise).
  Future<bool> ping() async {
    await customSelect('SELECT 1').get();
    return true;
  }

  /// Folder of the database inside `STORAGE_VOLUME_PATH`. It starts with a
  /// dot, so it isn't a valid bucket and isn't listed.
  static const String folderName = '.db';

  static const String fileName = 'feather-io.sqlite';

  /// `STORAGE_VOLUME_PATH/.db/feather-io.sqlite`: the metadata lives in the
  /// same volume as the objects it describes.
  static String get defaultPath =>
      p.join(env.storageVolumePath, folderName, fileName);

  static QueryExecutor _openConnection() {
    final file = File(defaultPath);
    // SQLite creates the file but not its folder
    file.parent.createSync(recursive: true);
    return NativeDatabase.createInBackground(file, setup: _setUp);
  }

  /// WAL with `synchronous=NORMAL`: a write goes to the log without waiting
  /// for several fsyncs (the default rollback journal with `synchronous=FULL`
  /// made small uploads 5x slower, see `service/tool/benchmark/RESULTS.md`).
  /// A crash of the process loses nothing; a power loss may lose the last
  /// writes, never corrupt the database. Readers don't wait for a writer.
  static void _setUp(Database database) {
    database
      ..execute('PRAGMA journal_mode = WAL')
      ..execute('PRAGMA synchronous = NORMAL');
  }
}
