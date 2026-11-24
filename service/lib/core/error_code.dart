import 'package:service/feather.dart';

/// Every error of the service's own API (the admin API): its stable code and
/// its status. The S3 API answers S3's codes ([S3ErrorCode]), and so does the
/// admin API for what the two share (a bucket or an object).
///
/// [code] is the i18n key of its message without `errors.`; clients decide on
/// it, never on the text, so renaming one is a breaking change of the API.
enum ErrorCode {
  authInvalidCredentials('auth.invalidCredentials', StatusCode.forbidden),
  authTooManyLoginAttempts(
    'auth.tooManyLoginAttempts',
    StatusCode.tooManyRequests,
  ),
  accessKeysNotFound('accessKeys.notFound', StatusCode.notFound),
  bucketsMissingFolderPrefix(
    'buckets.missingFolderPrefix',
    StatusCode.badRequest,
  );

  final String code;
  final StatusCode status;

  const ErrorCode(this.code, this.status);
}
