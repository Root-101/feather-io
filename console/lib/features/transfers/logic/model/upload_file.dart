/// A file to upload: its path inside the target folder (`photos/a.jpg` when it
/// comes in a folder), its size and how to read it, whole or a byte range
class UploadFile {
  final String name;
  final int size;

  /// The bytes from `start` (0 when null) to `end` (the size when null)
  final Stream<List<int>> Function(int? start, int? end) read;

  const UploadFile({
    required this.name,
    required this.size,
    required this.read,
  });

  Stream<List<int>> openRead([int? start, int? end]) => read(start, end);
}
