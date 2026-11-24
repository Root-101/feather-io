import 'package:console/app_exporter.dart';

/// An upload or a download of the transfer queue
class TransferTask {
  final String id;
  final TransferDirection direction;
  final String bucket;

  /// Name shown: the uploaded file's or the downloaded zip's
  final String name;

  /// Target (upload) or source (download) folder inside the bucket
  /// (`photos/2026/`), empty at the root
  final String folder;

  /// Upload: the target key and the file, kept to retry
  final String? key;
  final UploadFile? file;

  /// Download: the keys that go in the zip
  final List<String> keys;

  /// Total bytes; in a download, 0 until the service sends the zip
  final int size;

  /// Bytes sent or received
  final int transferred;
  final TransferStatus status;
  final GlobalException? error;

  const TransferTask({
    required this.id,
    required this.direction,
    required this.bucket,
    required this.name,
    required this.folder,
    this.key,
    this.file,
    this.keys = const [],
    this.size = 0,
    this.transferred = 0,
    this.status = TransferStatus.queued,
    this.error,
  });

  bool get isUpload => direction == TransferDirection.upload;

  /// From 0 to 1
  double get progress {
    if (status == TransferStatus.done) return 1;
    return size == 0 ? 0 : (transferred / size).clamp(0, 1);
  }

  TransferTask copyWith({
    int? size,
    int? transferred,
    TransferStatus? status,
    GlobalException? error,
    bool clearError = false,
  }) {
    return TransferTask(
      id: id,
      direction: direction,
      bucket: bucket,
      name: name,
      folder: folder,
      key: key,
      file: file,
      keys: keys,
      size: size ?? this.size,
      transferred: transferred ?? this.transferred,
      status: status ?? this.status,
      error: clearError ? null : error ?? this.error,
    );
  }

  /// Folder that contains [key] (`photos/2026/` for `photos/2026/a.jpg` and for
  /// the folder `photos/2026/b/`)
  static String parentFolder(String key) {
    final path = key.endsWith('/') ? key.substring(0, key.length - 1) : key;
    return path.substring(0, path.lastIndexOf('/') + 1);
  }
}
