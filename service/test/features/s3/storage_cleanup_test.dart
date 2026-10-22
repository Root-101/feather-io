@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:service/feather.dart';
import 'package:test/test.dart';

import '../../support/test_server.dart';

void main() {
  final server = TestServer(port: 8116, name: 'storage_cleanup');
  const bucket = 'cleanup-bucket';

  setUpAll(() async {
    await server.start();
    await server.createBucket(bucket);
  });
  tearDownAll(server.stop);

  group('ObjectService.deleteStaleTemps', () {
    test('Should delete the temp files older than a day and keep the rest', () async {
      final dir = Directory('${server.storagePath}/${ObjectService.tempFolderName}')
        ..createSync(recursive: true);
      final old = File('${dir.path}/old.tmp')..writeAsStringSync('left over');
      old.setLastModifiedSync(DateTime.now().subtract(const Duration(days: 2)));
      final recent = File('${dir.path}/recent.tmp')..writeAsStringSync('uploading');

      expect(await di.find<ObjectService>().deleteStaleTemps(), 1);
      expect(old.existsSync(), isFalse);
      expect(recent.existsSync(), isTrue);
    });
  });

  group('MultipartService.abortStale', () {
    Future<String> start(String key) async {
      final response = await http.post(
        server.url('/$bucket/$key?uploads'),
        headers: server.auth(json: true),
      );
      expect(response.statusCode, 200, reason: response.body);
      return jsonDecode(response.body)['upload_id'] as String;
    }

    test('Should abort the uploads started more than a week ago', () async {
      final oldId = await start('old.bin');
      final recentId = await start('recent.bin');
      final info = File(
        '${server.storagePath}/${MultipartService.folderName}/$oldId/upload.json',
      );
      final json = jsonDecode(info.readAsStringSync()) as Map<String, dynamic>;
      json['initiated'] = DateTime.now()
          .toUtc()
          .subtract(const Duration(days: 8))
          .toIso8601String();
      info.writeAsStringSync(jsonEncode(json));

      expect(await MultipartService().abortStale(), 1);

      final listed = await http.get(
        server.url('/$bucket?uploads'),
        headers: server.auth(json: true),
      );
      final ids = (jsonDecode(listed.body) as List).map((u) => u['upload_id']);
      expect(ids, [recentId]);
    });
  });
}
