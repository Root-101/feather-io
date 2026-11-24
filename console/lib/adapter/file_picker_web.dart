import 'dart:async';
import 'dart:js_interop';

import 'package:console/app_exporter.dart';
import 'package:web/web.dart' as web;

// webkitRelativePath is not part of the standard File API,
// so it is exposed as an extension type over web.File.
extension type _FileWithRelativePath(web.File file) implements web.File {
  external String? get webkitRelativePath;
}

class FilePicker {
  /// Reads only the range asked for: an upload in parts keeps one part in memory
  static UploadFile _upload(web.File file) {
    final relativePath = _FileWithRelativePath(file).webkitRelativePath;
    final name = (relativePath != null && relativePath.isNotEmpty)
        ? relativePath
        : file.name;
    return UploadFile(
      name: name,
      size: file.size,
      read: (start, end) async* {
        final slice = file.slice(start ?? 0, end ?? file.size);
        final buffer = await slice.arrayBuffer().toDart;
        yield buffer.toDart.asUint8List();
      },
    );
  }

  static Future<List<UploadFile>> pickFiles({bool multiple = true}) async {
    return _pickFiles(directory: false, multiple: true);
  }

  static Future<List<UploadFile>> pickDirectory() async {
    return _pickFiles(directory: true, multiple: false);
  }

  static Future<List<UploadFile>> _pickFiles({
    bool directory = false,
    bool multiple = true,
  }) async {
    final input = web.HTMLInputElement()..type = 'file';
    if (directory) {
      input.setAttribute('webkitdirectory', 'true');
      input.setAttribute('directory', 'true');
    } else {
      input.multiple = multiple;
    }

    final completer = Completer<void>();
    input.addEventListener(
      'change',
      (web.Event event) {
        completer.complete();
      }.toJS,
    );

    input.click();
    await completer.future;

    final fileList = input.files;
    if (fileList == null) return [];

    final files = <UploadFile>[];
    for (var i = 0; i < fileList.length; i++) {
      final file = fileList.item(i);
      if (file == null) continue;
      files.add(_upload(file));
    }
    return files;
  }
}
