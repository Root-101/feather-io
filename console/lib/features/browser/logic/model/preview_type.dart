/// The type an object is opened with in a new tab. The tab is a `blob:` URL of
/// the console's origin, and the type comes from whoever uploaded the object
/// (an anonymous writer too): an HTML or SVG opened as such would run its
/// script next to the session. Only the types the browser shows without running
/// anything keep theirs; text and markup are shown as text, the rest is downloaded
abstract class PreviewType {
  static final RegExp _inert = RegExp(
    r'^(image/(png|jpeg|gif|webp|avif|bmp|x-icon|vnd\.microsoft\.icon)'
    r'|video/[\w.+-]+|audio/[\w.+-]+|application/pdf)$',
  );

  static final RegExp _text = RegExp(
    r'^(text/[\w.+-]+|application/([\w.-]+\+)?(json|xml|javascript)|[\w.-]+/[\w.-]+\+xml)$',
  );

  static const String text = 'text/plain; charset=utf-8';
  static const String download = 'application/octet-stream';

  static String of(String? contentType) {
    final mime = (contentType ?? '').split(';').first.trim().toLowerCase();
    if (_inert.hasMatch(mime)) return mime;
    if (_text.hasMatch(mime)) return text;
    return download;
  }
}
