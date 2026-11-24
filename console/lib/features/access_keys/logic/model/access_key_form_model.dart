import 'package:console/app_exporter.dart';

/// What the create/edit drawer sends: the scope is [allBuckets] or [grants]
class AccessKeyFormModel {
  final String name;
  final bool enabled;
  final AccessKeyLevel? allBuckets;
  final List<AccessKeyGrantModel> grants;
  final DateTime? expiresAt;

  const AccessKeyFormModel({
    required this.name,
    required this.enabled,
    required this.allBuckets,
    required this.grants,
    required this.expiresAt,
  });

  /// The same key with [enabled] changed, for *Disable*/*Enable*
  factory AccessKeyFormModel.of(AccessKeyModel key, {bool? enabled}) {
    return AccessKeyFormModel(
      name: key.name,
      enabled: enabled ?? key.enabled,
      allBuckets: key.allBuckets,
      grants: key.grants,
      expiresAt: key.expiresAt,
    );
  }
}
