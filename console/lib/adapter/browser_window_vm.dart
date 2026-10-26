/// Outside the browser there is no window: nothing is opened or guarded
class BrowserWindow {
  static void openBytes(List<int> bytes, {String? contentType}) {}

  static void openUrl(String url) {}

  static void guardLeave(bool on) {}
}
