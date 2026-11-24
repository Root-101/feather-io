import 'package:console/app_exporter.dart';

/// The managed keys plus the id of the root key (`FEATHER_ACCESS`), which
/// can't be edited or deleted and is the only one that opens the console
class AccessKeyListModel {
  final String rootAccessKeyId;
  final List<AccessKeyModel> keys;

  const AccessKeyListModel({required this.rootAccessKeyId, required this.keys});
}
