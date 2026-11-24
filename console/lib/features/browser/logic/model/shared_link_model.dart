/// Link (presigned URL) to download an object without credentials
class SharedLinkModel {
  final String url;
  final DateTime expiresAt;

  SharedLinkModel({required this.url, required this.expiresAt});
}
