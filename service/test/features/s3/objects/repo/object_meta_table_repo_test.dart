import 'package:drift/native.dart';
import 'package:service/feather.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late ObjectMetaTableRepo repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ObjectMetaTableRepo(db);
  });
  tearDown(() => db.close());

  Future<void> save(String key) => repo.save(
    bucketName: 'b',
    key: key,
    etag: 'e',
    size: 1,
    modified: DateTime(2026),
    headers: '{}',
  );

  group('ObjectMetaTableRepo.deleteByPrefix', () {
    test('Should delete the rows of a folder whose name has an emoji', () async {
      for (final key in ['📷/a.jpg', '📷/sub/b.jpg', '📸/c.jpg', 'other.txt']) {
        await save(key);
      }

      await repo.deleteByPrefix('b', '📷/');

      expect(await repo.find('b', '📷/a.jpg'), isNull);
      expect(await repo.find('b', '📷/sub/b.jpg'), isNull);
      expect(await repo.find('b', '📸/c.jpg'), isNotNull);
      expect(await repo.find('b', 'other.txt'), isNotNull);
    });
  });
}
