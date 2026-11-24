import 'package:service/feather.dart';

/// The routes of the S3 API. S3 multiplexes several operations on one method
/// and path, told apart by the query and the headers (`PUT /{bucket}/{key}` is
/// PutObject, CopyObject, UploadPart or UploadPartCopy): each route sends the
/// request to the operation of [BucketController], [ObjectController] or
/// [MultipartController] it is.
class S3Controller {
  final BucketController buckets = di.find();
  final ObjectController objects = di.find();
  final MultipartController multipart = di.find();

  /// Like S3, no response gets a `Cache-Control` it wasn't stored with:
  /// `AuthFilter(cacheControl: null)` (Winter adds `private` by default). An
  /// object is the same for whoever may read it, a shared cache doesn't keep
  /// the answer to a request with `Authorization` (RFC 9111 §3.5), and a public
  /// prefix stays cacheable by a CDN
  Route get routing {
    return Route.parent(
      path: '/',
      filterConfig: FilterConfig([
        S3BucketNameFilter(),
        UnsupportedSubresourceFilter(),
        JwtFilter(),
        S3SigV4Filter(),
        AnonymousAccessFilter(),
      ]),
      routes: [
        Route.get(
          key: Permissions.s3ListBuckets,
          path: '/',
          handler: buckets.listBuckets,
          filterConfig: FilterConfig([
            AuthFilter(
              cacheControl: null,
              rule: hasPermission(Permissions.s3ListBuckets),
            ),
          ]),
        ),
        Route.put(
          key: Permissions.s3CreateBucket,
          path: '/{bucket}',
          handler: buckets.createBucket,
          filterConfig: FilterConfig([
            AuthFilter(
              cacheControl: null,
              rule: hasPermission(Permissions.s3CreateBucket),
            ),
            ReservedBucketFilter(),
          ]),
        ),
        Route.delete(
          key: Permissions.s3DeleteBucket,
          path: '/{bucket}',
          handler: buckets.deleteBucket,
          filterConfig: FilterConfig([
            AuthFilter(
              cacheControl: null,
              rule: hasPermission(Permissions.s3DeleteBucket),
            ),
            ReservedBucketFilter(),
          ]),
        ),
        Route.get(
          key: Permissions.s3ListObjects,
          path: '/{bucket}',
          handler: _getBucket,
          filterConfig: FilterConfig([
            AuthFilter(
              cacheControl: null,
              rule:
                  hasPermission(Permissions.s3ListObjects) |
                  hasPermission(
                    Permissions.anonymous(Permissions.s3ListObjects),
                  ),
              shouldFilter: (request) {
                // Only for this very route, so the child routes don't inherit
                // it: get-object must not need the list-objects permission
                return request.route?.key == Permissions.s3ListObjects;
              },
            ),
            ReservedBucketFilter(),
          ]),
          routes: [
            Route.put(
              key: Permissions.s3PutObject,
              path: '/{key|.*}',
              handler: _putObject,
              filterConfig: FilterConfig([
                AuthFilter(
                  cacheControl: null,
                  rule:
                      hasPermission(Permissions.s3PutObject) |
                      hasPermission(
                        Permissions.anonymous(Permissions.s3PutObject),
                      ),
                ),
              ]),
            ),
            // CreateMultipartUpload (?uploads) and CompleteMultipartUpload (?uploadId)
            Route.post(
              key: 's3.post-object',
              path: '/{key|.*}',
              handler: _postObject,
              filterConfig: FilterConfig([
                AuthFilter(
                  cacheControl: null,
                  rule: hasPermission(Permissions.s3PutObject),
                ),
              ]),
            ),
            Route.get(
              key: Permissions.s3GetObject,
              path: '/{key|.*}',
              handler: _getObject,
              filterConfig: FilterConfig([
                AuthFilter(
                  cacheControl: null,
                  rule:
                      hasPermission(Permissions.s3GetObject) |
                      hasPermission(
                        Permissions.anonymous(Permissions.s3GetObject),
                      ),
                ),
              ]),
            ),
            Route.delete(
              key: Permissions.s3DeleteObject,
              path: '/{key|.*}',
              handler: _deleteObject,
              filterConfig: FilterConfig([
                AuthFilter(
                  cacheControl: null,
                  rule:
                      hasPermission(Permissions.s3DeleteObject) |
                      hasPermission(
                        Permissions.anonymous(Permissions.s3DeleteObject),
                      ),
                ),
              ]),
            ),
          ],
        ),
        Route.post(
          key: Permissions.s3MultiDeleteObjects,
          path: '/{bucket}',
          handler: objects.deleteObjects,
          filterConfig: FilterConfig([
            AuthFilter(
              cacheControl: null,
              rule: hasPermission(Permissions.s3MultiDeleteObjects),
            ),
            ReservedBucketFilter(),
          ]),
        ),
      ],
    );
  }

  /// `GET /{bucket}`: GetBucketLocation, ListMultipartUploads,
  /// GetBucketVersioning or ListObjects.
  Future<ResponseEntity> _getBucket(RequestEntity request) {
    final query = request.queryParams;
    if (query.containsKey('location')) return buckets.bucketLocation(request);
    if (query.containsKey('uploads')) return multipart.listUploads(request);
    if (query.containsKey('versioning')) {
      return buckets.bucketVersioning(request);
    }
    return buckets.listObjects(request);
  }

  /// `PUT /{bucket}/{key}`: UploadPart (and UploadPartCopy), CopyObject or
  /// PutObject.
  Future<ResponseEntity> _putObject(RequestEntity request) {
    if (request.queryParams.containsKey('uploadId')) {
      return multipart.uploadPart(request);
    }
    if (request.headers['x-amz-copy-source'] != null) {
      return objects.copyObject(request);
    }
    return objects.putObject(request);
  }

  /// `POST /{bucket}/{key}`: only the multipart operations.
  Future<ResponseEntity> _postObject(RequestEntity request) async {
    if (request.queryParams.containsKey('uploads')) {
      return multipart.create(request);
    }
    if (request.queryParams.containsKey('uploadId')) {
      return multipart.complete(request);
    }
    throw S3Exception(
      S3ErrorCode.invalidRequest,
      message: intl.errors.multipart.postNotSupported,
      resource: request.objectKey,
    );
  }

  /// `GET /{bucket}/{key}` (and HEAD): ListParts, GetObjectTagging or
  /// GetObject.
  Future<ResponseEntity> _getObject(RequestEntity request) {
    if (request.queryParams.containsKey('uploadId')) {
      return multipart.listParts(request);
    }
    if (request.queryParams.containsKey('tagging')) {
      return objects.objectTagging(request);
    }
    return objects.getObject(request);
  }

  /// `DELETE /{bucket}/{key}`: AbortMultipartUpload or DeleteObject.
  Future<ResponseEntity> _deleteObject(RequestEntity request) {
    if (request.queryParams.containsKey('uploadId')) {
      return multipart.abort(request);
    }
    return objects.deleteObject(request);
  }
}
