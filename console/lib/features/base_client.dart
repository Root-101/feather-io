import 'package:dio/dio.dart';

enum AcceptedTypes {
  json('application/json'),
  xml('application/xml');

  final String contentType;

  const AcceptedTypes(this.contentType);
}

abstract class BaseClient {
  String get baseUrl;

  final Dio dio;

  BaseClient(this.dio);

  /// The URL of an object: each segment of [key] encoded, so that a `#`, `?` or
  /// `%` in a name is part of the key and not a fragment, a query or an escape
  /// that the service would decode into another key
  String objectUrl(String bucket, String key) =>
      '$baseUrl/$bucket/${key.split('/').map(Uri.encodeComponent).join('/')}';

  Options options({String? token, AcceptedTypes? accept}) {
    return Options(
      headers: <String, dynamic>{
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': (accept ?? AcceptedTypes.json).contentType,
      },
    );
  }
}
