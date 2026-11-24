import 'package:console/app_exporter.dart';

extension GlobalExceptionIntl on GlobalException {
  /// The text for the user in the current language. With `custom` the
  /// `message` already is one; the rest is translated by its `code`
  String get intlMessage => switch (code) {
    GlobalExceptionCode.custom => message,
    GlobalExceptionCode.cancelled => app.intl.errors.requestCancelled,
    GlobalExceptionCode.connectionTimeout => app.intl.errors.connectionTimeout,
    GlobalExceptionCode.noConnection => app.intl.errors.noConnection,
    GlobalExceptionCode.receiveTimeout => app.intl.errors.receiveTimeout,
    GlobalExceptionCode.sendTimeout => app.intl.errors.sendTimeout,
    GlobalExceptionCode.badCertificate => app.intl.errors.badCertificate,
    // on web a network failure comes as a connection error: the canvas' text
    GlobalExceptionCode.connectionError => app.intl.errors.connection,
    GlobalExceptionCode.validation => app.intl.errors.validation,
    GlobalExceptionCode.serverError => app.intl.errors.server,
    GlobalExceptionCode.unknown => app.intl.errors.unknown,
  };
}
