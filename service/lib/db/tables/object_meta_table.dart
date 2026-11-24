import 'package:drift/drift.dart';
import 'package:service/feather.dart';

/// Metadata of each object, stored when it is written: its ETag (md5) and the
/// headers it was uploaded with (`Content-Type`, `x-amz-meta-*`…). [size] and
/// [modified] are the file's at that moment: if they don't match the current
/// ones, the file changed outside the service and the ETag is recomputed.
class ObjectMetaTable extends Table {
  @override
  String get tableName => 'object_meta';

  TextColumn get bucketName => text().references(BucketTable, #name)();

  TextColumn get objectKey => text()();

  TextColumn get etag => text()();

  IntColumn get size => integer()();

  /// File modification time, in microseconds since the epoch.
  IntColumn get modified => integer()();

  /// Object headers as JSON (`{"content-type": "image/png", …}`).
  TextColumn get headers => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {bucketName, objectKey};
}
