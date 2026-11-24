import 'package:drift/drift.dart';
import 'package:service/feather.dart';

/// Access keys for native S3 clients, besides the root key of the env. The
/// secret is stored encrypted ([SecretCipher]), never in plain text.
class AccessKeyTable extends Table {
  @override
  String get tableName => 'access_key';

  /// Access key id (`FIOK…`), the one clients send in the signature.
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get secretEncrypted => text()();

  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  /// Level on every bucket; null when the key only reaches the buckets of
  /// [AccessKeyGrantTable].
  TextColumn get allBuckets => textEnum<AccessKeyLevel>().nullable()();

  DateTimeColumn get expiresAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get lastUsedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Level of an access key on one bucket.
class AccessKeyGrantTable extends Table {
  @override
  String get tableName => 'access_key_grant';

  TextColumn get keyId => text().references(AccessKeyTable, #id)();

  TextColumn get bucketName => text().references(BucketTable, #name)();

  TextColumn get access => textEnum<AccessKeyLevel>()();

  @override
  Set<Column> get primaryKey => {keyId, bucketName};
}
