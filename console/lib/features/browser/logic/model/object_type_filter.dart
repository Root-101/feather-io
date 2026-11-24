import 'package:mime/mime.dart';

/// Category of an object by its MIME type (inferred from the name)
enum ObjectTypeFilter {
  image,
  video,
  audio,
  document,
  archive,
  other;

  static const _documentMimes = {
    'application/pdf',
    'application/json',
    'application/xml',
    'application/rtf',
    'application/msword',
    'application/vnd.ms-excel',
    'application/vnd.ms-powerpoint',
  };

  static ObjectTypeFilter of(String fileName) {
    final mime = lookupMimeType(fileName);
    if (mime == null) return other;
    if (mime.startsWith('image/')) return image;
    if (mime.startsWith('video/')) return video;
    if (mime.startsWith('audio/')) return audio;
    if (mime.startsWith('text/') ||
        _documentMimes.contains(mime) ||
        mime.startsWith('application/vnd.openxmlformats-officedocument.') ||
        mime.startsWith('application/vnd.oasis.opendocument.')) {
      return document;
    }
    if (mime.contains('zip') ||
        mime.contains('compressed') ||
        mime == 'application/x-tar' ||
        mime == 'application/gzip') {
      return archive;
    }
    return other;
  }
}
