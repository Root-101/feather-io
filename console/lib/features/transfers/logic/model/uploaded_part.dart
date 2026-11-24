/// Part of a multipart upload already uploaded
class UploadedPart {
  final int number;
  final String etag;

  const UploadedPart({required this.number, required this.etag});
}
