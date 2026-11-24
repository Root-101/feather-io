import 'package:console/app_exporter.dart';

/// Anonymous access rule: a prefix of the bucket, or a pattern with `*` as a
/// wildcard, reachable without credentials
class AnonymousRuleModel {
  final String prefix;
  final AnonymousAccessType access;

  AnonymousRuleModel({required this.prefix, required this.access});
}
