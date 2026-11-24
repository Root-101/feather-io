import 'package:dio/dio.dart';

/// Sends the app's language with every request (`Accept-Language`): the service
/// answers its error messages in it (`en` or `es`; any other gets English)
class LanguageHeaderInterceptor extends Interceptor {
  /// Code of the app's current language (`en`, `es`), read on each request
  final String Function() languageCode;

  LanguageHeaderInterceptor({required this.languageCode});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = languageCode();
    handler.next(options);
  }
}
