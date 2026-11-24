import 'package:console/app_exporter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _answer(int status, Object? body) {
  final request = RequestOptions(path: '/x');
  return DioException(
    requestOptions: request,
    type: DioExceptionType.badResponse,
    response: Response(requestOptions: request, statusCode: status, data: body),
  );
}

void main() {
  setUp(() => AppIntl.current = AppLocale.en);
  tearDown(() => AppIntl.current = AppLocale.en);

  test('A Problem Details keeps its detail, status and code', () {
    final exception = ExceptionConverter.parse(
      _answer(409, {
        'title': 'Conflict',
        'detail': 'The bucket "photos" is not empty',
        'code': 'BucketNotEmpty',
      }),
    );
    expect(exception.type, GlobalExceptionType.conflict);
    expect(exception.code, GlobalExceptionCode.custom);
    expect(exception.statusCode, 409);
    expect(exception.errorCode, 'BucketNotEmpty');
    expect(exception.hasCode('BucketNotEmpty'), isTrue);
    expect(exception.intlMessage, 'The bucket "photos" is not empty');
  });

  test('A 422 carries its violations, and their codes', () {
    final exception = ExceptionConverter.parse(
      _answer(422, {
        'violations': [
          {'fieldName': 'name', 'message': 'Too short', 'code': 'size.min'},
        ],
      }),
    );
    expect(exception.type, GlobalExceptionType.validation);
    expect(exception.code, GlobalExceptionCode.validation);
    expect((exception.data as List<ValidationError>).single.source, 'name');
    expect(exception.hasCode('size.min'), isTrue);
  });

  test('A network failure is translated, not shown in English', () {
    final exception = ExceptionConverter.parse(
      DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.connectionTimeout,
      ),
    );
    expect(exception.code, GlobalExceptionCode.connectionTimeout);
    AppIntl.current = AppLocale.es;
    expect(
      exception.intlMessage,
      AppIntl.of(AppLocale.es).errors.connectionTimeout,
    );
  });

  test('A server error and anything unexpected have their own texts', () {
    expect(
      ExceptionConverter.parse(_answer(500, 'boom')).intlMessage,
      AppIntl.of(AppLocale.en).errors.server,
    );
    expect(
      ExceptionConverter.parse(StateError('x')).intlMessage,
      AppIntl.of(AppLocale.en).errors.unknown,
    );
  });
}
