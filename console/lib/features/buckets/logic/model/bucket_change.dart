/// What happened to a bucket
enum BucketChange {
  created,

  /// Its description or color changed
  updated,

  /// All its objects were deleted
  emptied,
  deleted,

  /// Objects were uploaded or deleted (its statistics change)
  objectsChanged,
}
