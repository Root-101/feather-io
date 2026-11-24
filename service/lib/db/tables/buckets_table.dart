import 'package:drift/drift.dart';

class BucketTable extends Table {
  @override
  String get tableName => 'bucket';

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  IntColumn get color => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {name};
}
