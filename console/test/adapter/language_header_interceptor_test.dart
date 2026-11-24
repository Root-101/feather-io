import 'package:console/app_exporter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _Handler extends RequestInterceptorHandler {
  RequestOptions? passed;

  @override
  void next(RequestOptions requestOptions) => passed = requestOptions;
}

void main() {
  test('Sends the current language on every request', () {
    var language = 'en';
    final interceptor = LanguageHeaderInterceptor(languageCode: () => language);

    final first = _Handler();
    interceptor.onRequest(RequestOptions(path: '/a'), first);
    expect(first.passed!.headers['Accept-Language'], 'en');

    language = 'es';
    final second = _Handler();
    interceptor.onRequest(RequestOptions(path: '/b'), second);
    expect(second.passed!.headers['Accept-Language'], 'es');
  });
}
