import 'package:console/app_exporter.dart';

/// Outside the browser there is no file dialog: nothing is picked
class FilePicker {
  static Future<List<UploadFile>> pickFiles({bool multiple = true}) async => [];

  static Future<List<UploadFile>> pickDirectory() async => [];
}
