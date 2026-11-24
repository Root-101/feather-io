import 'package:console/app_exporter.dart';

/// `conflict` is this app's (409: a name already taken is shown on its field)
enum GlobalExceptionType { general, auth, validation, conflict }

/// What happened, without text, so the view can translate it
/// ([GlobalExceptionIntl]). [custom]: the `message` is already for the user
/// (the service's `detail`, in the language of the request, or a text of the
/// app); for the rest it is an English fallback for logs
enum GlobalExceptionCode {
  custom,
  cancelled,
  connectionTimeout,
  noConnection,
  receiveTimeout,
  sendTimeout,
  badCertificate,
  connectionError,
  validation,
  serverError,
  unknown,
}

class GlobalException<T> implements Exception {
  final GlobalExceptionType type;
  final String message;
  final T? data;
  final GlobalExceptionCode code;

  /// HTTP status, when the error is an answer of the service
  final int? statusCode;

  /// The stable `code` of the service's Problem Details (`NoSuchBucket`,
  /// `BucketNotEmpty`…), the same in every language: compare it, never the text
  final String? errorCode;

  GlobalException({
    required this.type,
    required this.message,
    this.data,
    this.code = GlobalExceptionCode.custom,
    this.statusCode,
    this.errorCode,
  });

  /// The service answered with that code, as the Problem Details' `code` or in
  /// a violation of a 422
  bool hasCode(String apiCode) =>
      errorCode == apiCode ||
      (data is List<ValidationError> &&
          (data as List<ValidationError>).any(
            (error) => error.code == apiCode,
          ));

  @override
  String toString() {
    return 'GlobalException{type: $type, code: $code, statusCode: $statusCode, errorCode: $errorCode, message: $message, data: $data}';
  }
}
