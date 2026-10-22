import 'package:service/feather.dart';
import 'package:test/test.dart';

void main() {
  group('ExtendedEnv.shortSecrets', () {
    setUp(() {
      env.put('FEATHER_SECRET', 'a' * 16);
      env.put('JWT_SECRET', 'b' * 32);
      env.put('KEYS_ENCRYPTION_SECRET', 'c' * 32);
    });

    test('Should be empty when every secret is long enough', () {
      expect(env.shortSecrets, isEmpty);
    });

    test('Should name the secrets below their length', () {
      env.put('FEATHER_SECRET', 'secret');
      env.put('JWT_SECRET', 'b' * 31);
      expect(env.shortSecrets, ['FEATHER_SECRET', 'JWT_SECRET']);
    });
  });
}
