import 'package:console/app_exporter.dart';

class AccessKeysInit {
  static Future init() async {
    AccessKeysClient client = AccessKeysClient(app.di.find());
    app.di.put(client);

    AccessKeysRepo repo = AccessKeysRepo(client);
    app.di.put(repo);
  }
}
