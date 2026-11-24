import 'package:console/app_exporter.dart';

/// Level of a key on one bucket
class AccessKeyGrantModel {
  final String bucket;
  final AccessKeyLevel access;

  const AccessKeyGrantModel({required this.bucket, required this.access});
}
