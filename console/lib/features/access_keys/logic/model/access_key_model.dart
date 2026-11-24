import 'package:console/app_exporter.dart';

/// Access key for native S3 clients. It reaches every bucket with
/// [allBuckets], or only the buckets of [grants]
class AccessKeyModel {
  final String id;
  final String name;
  final bool enabled;
  final bool expired;
  final AccessKeyLevel? allBuckets;
  final List<AccessKeyGrantModel> grants;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime? lastUsedAt;

  /// Only right after creating the key or regenerating its secret: the service
  /// never returns it again
  final String? secret;

  const AccessKeyModel({
    required this.id,
    required this.name,
    required this.enabled,
    required this.expired,
    required this.allBuckets,
    required this.grants,
    required this.expiresAt,
    required this.createdAt,
    required this.lastUsedAt,
    this.secret,
  });

  AccessKeyStatus get status => !enabled
      ? AccessKeyStatus.disabled
      : expired
      ? AccessKeyStatus.expired
      : AccessKeyStatus.active;
}
