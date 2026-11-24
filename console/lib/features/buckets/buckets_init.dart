import 'package:console/app_exporter.dart';

class BucketsInit {
  static Future init() async {
    BucketsClient client = BucketsClient(app.di.find());
    app.di.put(client);

    BucketsRepo repo = BucketsRepo(client);
    app.di.put(repo);
  }
}
