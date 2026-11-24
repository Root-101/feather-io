/// Headers of an object (`HEAD`), for its details panel
class ObjectInfoModel {
  final String? contentType;
  final int? sizeBytes;
  final DateTime? lastModified;

  ObjectInfoModel({this.contentType, this.sizeBytes, this.lastModified});
}
