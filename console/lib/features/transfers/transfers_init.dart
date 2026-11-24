import 'package:console/app_exporter.dart';

class TransfersInit {
  static Future init() async {
    TransfersClient client = TransfersClient(app.di.find());
    app.di.put(client);

    TransfersRepo repo = TransfersRepo(client);
    app.di.put(repo);

    TransfersCubit cubit = TransfersCubit(repo, app.di.find());
    app.di.put(cubit);
  }
}
