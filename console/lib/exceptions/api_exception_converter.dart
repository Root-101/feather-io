import 'package:console/app_exporter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A `DioException` as a [GlobalException]: a code for what happened (the view
/// translates it with `intlMessage`) and, for an answer of the service, its
/// status, its Problem Details `code` and its `detail`
class ApiExceptionConverter {
  static GlobalException parse(DioException error) {
    return switch (error.type) {
      DioExceptionType.cancel => _general(
        GlobalExceptionCode.cancelled,
        'Request cancelled',
      ),
      DioExceptionType.connectionTimeout => _general(
        GlobalExceptionCode.connectionTimeout,
        'Connection timeout',
      ),
      DioExceptionType.transformTimeout || DioExceptionType.unknown => _general(
        GlobalExceptionCode.noConnection,
        'No connection',
      ),
      DioExceptionType.receiveTimeout => _general(
        GlobalExceptionCode.receiveTimeout,
        'Receive timeout',
      ),
      DioExceptionType.sendTimeout => _general(
        GlobalExceptionCode.sendTimeout,
        'Send timeout',
      ),
      DioExceptionType.badCertificate => _general(
        GlobalExceptionCode.badCertificate,
        'Bad certificate',
      ),
      DioExceptionType.connectionError => GlobalException(
        // on web, Dio reports 403/401 as a connection error (the browser
        // closes the connection); every other status (200, 404, 422) works,
        // so this connection error is handled as an auth exception
        type: kIsWeb ? GlobalExceptionType.auth : GlobalExceptionType.general,
        code: GlobalExceptionCode.connectionError,
        message: 'Connection error',
      ),
      DioExceptionType.badResponse => _parseBadResponse(error),
    };
  }

  static GlobalException _general(GlobalExceptionCode code, String message) =>
      GlobalException(
        type: GlobalExceptionType.general,
        code: code,
        message: message,
      );

  static GlobalException _parseBadResponse(DioException error) {
    final status = error.response!.statusCode!;
    final body = error.response!.data;
    final errorCode = body is Map && body['code'] is String
        ? body['code'] as String
        : null;
    if (status == 422) {
      return GlobalException(
        type: GlobalExceptionType.validation,
        code: GlobalExceptionCode.validation,
        statusCode: status,
        errorCode: errorCode,
        message: 'Validation error',
        // A Problem Details with the list in `violations`
        data: ((body as Map)['violations'] as List<dynamic>)
            .map(
              (json) => ValidationError.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
      );
    }
    if (status >= 500) {
      return GlobalException(
        type: GlobalExceptionType.general,
        code: GlobalExceptionCode.serverError,
        statusCode: status,
        errorCode: errorCode,
        message: 'Server error',
        data: body,
      );
    }
    return GlobalException(
      type: status == 409
          ? GlobalExceptionType.conflict
          : GlobalExceptionType.general,
      statusCode: status,
      errorCode: errorCode,
      message: _message(body),
      data: body,
    );
  }

  /// Every error of the service is a Problem Details (RFC 9457): the text for
  /// the user is its `detail` (S3 errors add their `code` and `resource`).
  /// Without one, its `title` (the status); anything else as plain text
  static String _message(dynamic data) {
    if (data is Map) {
      for (final key in const ['detail', 'title']) {
        if (data[key] is String) return data[key] as String;
      }
    }
    return data?.toString() ?? '';
  }
}
