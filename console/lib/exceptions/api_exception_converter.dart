import 'package:console/app_exporter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiExceptionConverter {
  static GlobalException parse(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.requestCancelled,
        );
      case DioExceptionType.connectionTimeout:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.connectionTimeout,
        );
      case DioExceptionType.transformTimeout:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.noConnection,
        );
      case DioExceptionType.unknown:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.noConnection,
        );
      case DioExceptionType.receiveTimeout:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.receiveTimeout,
        );
      case DioExceptionType.sendTimeout:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.sendTimeout,
        );
      case DioExceptionType.badCertificate:
        return GlobalException(
          type: GlobalExceptionType.general,
          message: app.intl.errors.badCertificate,
        );
      case DioExceptionType.connectionError:
        // TODO: look at the web error in more detail
        if (kIsWeb) {
          return GlobalException(
            // on web, Dio reports 403/401 as a connection error (the browser closes the connection)
            // every other status (200, 404, 422) works, so this connection error is handled as an auth exception
            type: GlobalExceptionType.auth,
            message: app.intl.errors.connection,
          );
        } else {
          return GlobalException(
            type: GlobalExceptionType.general,
            message: app.intl.errors.connection,
          );
        }
      case DioExceptionType.badResponse:
        return _parseBadResponse(error);
    }
  }

  static GlobalException _parseBadResponse(DioException error) {
    if (error.response!.statusCode == 422) {
      return GlobalException(
        type: GlobalExceptionType.validation,
        message: app.intl.errors.validation,
        // A Problem Details with the list in `violations`
        data: ((error.response!.data as Map)['violations'] as List<dynamic>)
            .map(
              (json) => ValidationError.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
      );
    } else if (error.response!.statusCode == 409) {
      return GlobalException(
        type: GlobalExceptionType.conflict,
        message: _message(error.response!.data),
        data: error.response!.data,
      );
    } else if (error.response!.statusCode! >= 500) {
      return GlobalException(
        type: GlobalExceptionType.general,
        message: app.intl.errors.server,
        data: error.response!.data,
      );
    } else {
      return GlobalException(
        type: GlobalExceptionType.general,
        message: _message(error.response!.data),
        data: error.response!.data,
      );
    }
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
