/// Item (folder or object) as shown in the browser
class BrowserObjectWrapper {
  final String name;
  final bool isFolder;
  final int? size;
  final DateTime? lastModified;
  final String fullPath;

  BrowserObjectWrapper({
    required this.name,
    required this.isFolder,
    required this.fullPath,
    this.size,
    this.lastModified,
  });
}
