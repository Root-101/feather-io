import 'package:service/feather.dart';

/// What the console does with a bucket that the S3 API has no operation for:
/// its metadata and stats, presigned URLs, emptying it, deleting a folder with
/// its content and downloading several objects as a zip.
class BucketAdminController {
  final ObjectService objectService = di.find();
  final BucketService bucketService = di.find();
  final PresignService presignService = di.find();

  /// Presigned URL to download an object. It points to `PUBLIC_URL` or, without
  /// it, to the host this request arrived at; the host is part of the signature.
  Future<ResponseEntity> presignObject(RequestEntity request) async {
    // Validated by body<T>() (422)
    final presign = await request.body<PresignRequest>();

    // PUBLIC_URL if set; otherwise this request's scheme and host
    final publicUrl = env.publicUrl;
    final url = await presignService.presignGet(
      scheme: publicUrl?.scheme ?? request.requestedUri.scheme,
      host:
          publicUrl?.authority ??
          request.headers['host'] ??
          request.requestedUri.authority,
      bucketName: request.pathParams['bucket']!,
      key: presign.key!,
      expiresIn: Duration(seconds: presign.expiresIn!),
    );
    return ResponseEntity.ok(body: url);
  }

  Future<ResponseEntity> getBucket(RequestEntity request) async {
    final bucket = await bucketService.getBucket(
      bucketName: request.pathParams['bucket']!,
    );
    return ResponseEntity.ok(body: bucket);
  }

  Future<ResponseEntity> emptyBucket(RequestEntity request) async {
    await bucketService.emptyBucket(bucketName: request.pathParams['bucket']!);
    return ResponseEntity.noContent();
  }

  /// Deletes a folder with all its content: `?prefix=photos/`. Through the S3
  /// API, deleting `photos/` only removes the empty folder (its marker).
  Future<ResponseEntity> deleteFolder(RequestEntity request) async {
    final bucketName = request.pathParams['bucket']!;
    final prefix = request.queryParam<String>('prefix');
    if (prefix == null || prefix.isEmpty) {
      throw S3Exception(
        S3ErrorCode.invalidArgument,
        message: intl.errors.s3.missingFolderPrefix,
        resource: bucketName,
      );
    }
    await objectService.deleteFolder(bucketName: bucketName, prefix: prefix);
    return ResponseEntity.noContent();
  }

  Future<ResponseEntity> updateBucket(RequestEntity request) async {
    final bucketName = request.pathParams['bucket']!;

    // Validated by body<T>() (422)
    final updateRequest = await request.body<UpdateBucketRequest>();

    final bucket = await bucketService.updateBucket(
      bucketName: bucketName,
      description: updateRequest.description,
      color: updateRequest.color,
    );

    return ResponseEntity.ok(body: bucket);
  }

  Future<ResponseEntity> downloadObjects(RequestEntity request) async {
    final bucketName = request.pathParams['bucket']!;

    try {
      final downloadRequest = await request.body<DownloadObjectsRequest>();

      final zipFile = await objectService.zipObjects(
        bucketName: bucketName,
        keys: downloadRequest.keys,
      );

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'download_$timestamp.zip';

      return ResponseEntity<Stream<List<int>>>(
        200,
        body: objectService.openAndDeleteTemp(zipFile),
        headers: {
          'content-type': 'application/zip',
          'content-disposition': 'attachment; filename="$fileName"',
          'content-length': (await zipFile.length()).toString(),
        },
      );
    } catch (e) {
      // A body that isn't the expected JSON keeps its 400 with the field
      if (e is ApiException || e is DeserializationException) rethrow;
      throw S3Exception(
        S3ErrorCode.invalidRequest,
        message: intl.errors.admin.invalidRequest,
      );
    }
  }
}
