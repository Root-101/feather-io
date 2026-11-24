/// The permission of each endpoint, checked by its `AuthFilter`; the route's
/// key is its permission. The root key (the console's login) gets [all]; a
/// managed access key gets the S3 ones of its level (`S3SigV4Filter`), and an
/// anonymous rule the [anonymous] form of read or write.
abstract final class Permissions {
  //--------------- S3 API: the operations of S3 ---------------\\
  static const String s3ListBuckets = 's3.list-buckets';
  static const String s3CreateBucket = 's3.create-bucket';
  static const String s3DeleteBucket = 's3.delete-bucket';
  static const String s3ListObjects = 's3.list-objects';
  static const String s3PutObject = 's3.put-object';
  static const String s3GetObject = 's3.get-object';
  static const String s3DeleteObject = 's3.delete-object';
  static const String s3MultiDeleteObjects = 's3.multi-delete-objects';

  //--------------- Admin API ---------------\\
  static const String adminBucketGet = 'admin.bucket.get';
  static const String adminBucketUpdate = 'admin.bucket.update';
  static const String adminBucketPresign = 'admin.bucket.presign';
  static const String adminBucketEmpty = 'admin.bucket.empty';
  static const String adminBucketDeleteFolder = 'admin.bucket.delete-folder';
  static const String adminBucketDownload = 'admin.bucket.download';
  static const String adminAnonymousAccessGetRules =
      'admin.bucket.anonymous-access.get-rules';
  static const String adminAnonymousAccessWriteRule =
      'admin.bucket.anonymous-access.write-rule';
  static const String adminAnonymousAccessDeleteRule =
      'admin.bucket.anonymous-access.delete-rule';
  static const String adminAccessKeyList = 'admin.access-key.list';
  static const String adminAccessKeyCreate = 'admin.access-key.create';
  static const String adminAccessKeyUpdate = 'admin.access-key.update';
  static const String adminAccessKeyRegenerateSecret =
      'admin.access-key.regenerate-secret';
  static const String adminAccessKeyDelete = 'admin.access-key.delete';

  /// Every S3 operation: the root key's when it signs with SigV4.
  static const Set<String> s3 = {
    s3ListBuckets,
    s3CreateBucket,
    s3DeleteBucket,
    s3ListObjects,
    s3PutObject,
    s3GetObject,
    s3DeleteObject,
    s3MultiDeleteObjects,
  };

  /// What reading a bucket allows (an access key's `readOnly`).
  static const Set<String> s3Read = {s3ListObjects, s3GetObject};

  /// What writing a bucket allows (an access key's `writeOnly`). An anonymous
  /// rule never gets [s3MultiDeleteObjects]: its keys come in the body.
  static const Set<String> s3Write = {
    s3PutObject,
    s3DeleteObject,
    s3MultiDeleteObjects,
  };

  /// Every permission: what the token of the root key carries.
  static const Set<String> all = {
    ...s3,
    adminBucketGet,
    adminBucketUpdate,
    adminBucketPresign,
    adminBucketEmpty,
    adminBucketDeleteFolder,
    adminBucketDownload,
    adminAnonymousAccessGetRules,
    adminAnonymousAccessWriteRule,
    adminAnonymousAccessDeleteRule,
    adminAccessKeyList,
    adminAccessKeyCreate,
    adminAccessKeyUpdate,
    adminAccessKeyRegenerateSecret,
    adminAccessKeyDelete,
  };

  /// What an anonymous rule grants in place of [permission] (an S3 one):
  /// `s3.anonymous.get-object` for `s3.get-object`. The routes that accept
  /// anonymous requests take either.
  static String anonymous(String permission) =>
      permission.replaceFirst('s3.', 's3.anonymous.');
}
