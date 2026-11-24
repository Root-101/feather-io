import 'package:console/app_exporter.dart';

class ListObjectsModel {
  final String bucketName;
  final String? prefix;
  final String? delimiter;
  final List<BrowserObjectModel> objects;
  final List<String> commonPrefixes;

  /// There are more items after this page
  final bool isTruncated;

  /// Token to request the next page
  final String? nextContinuationToken;

  /// Items of the folder across all pages
  final int totalKeys;

  ListObjectsModel({
    required this.bucketName,
    required this.objects,
    required this.commonPrefixes,
    this.prefix,
    this.delimiter,
    this.isTruncated = false,
    this.nextContinuationToken,
    this.totalKeys = 0,
  });
}
