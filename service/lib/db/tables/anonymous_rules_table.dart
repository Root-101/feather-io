import 'package:drift/drift.dart';
import 'package:service/feather.dart';

class AnonymousRuleTable extends Table {
  @override
  String get tableName => 'anonymous_rule';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get bucketName => text().references(BucketTable, #name)();

  TextColumn get prefix => text()();

  TextColumn get access => textEnum<AnonymousAccessType>()();

  @override
  List<String> get customConstraints => ['UNIQUE (bucket_name, prefix)'];
}
