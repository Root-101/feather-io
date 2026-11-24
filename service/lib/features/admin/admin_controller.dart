import 'package:service/feather.dart';

class AdminController {
  /// Version of the admin API in its OpenAPI document.
  static const String apiVersion = '1.0.0';

  /// Route key of the health check (`GET /{admin}/health`).
  static const String healthKey = 'admin.health';

  final String adminPrefix = env.adminPrefix;

  final AuthController authController = di.find();
  final BucketAdminController buckets = di.find();
  final AnonymousAccessController anonymousAccessController = di.find();
  final AccessKeyController accessKeyController = di.find();

  /// The admin API, plus its OpenAPI document (`/{admin}/openapi.json`) and
  /// Swagger UI (`/{admin}/docs`). Both are public, like the login and the
  /// health check: they describe the API, never its data.
  Route get routing => Route.parent(
    path: '/$adminPrefix',
    filterConfig: _filters,
    routes: [
      ..._routes,
      Route.openApi(
        key: 'admin.openapi',
        openApi: OpenApi(
          title: 'Feather IO admin API',
          version: apiVersion,
          description:
              'The API of the console. Log in with `POST /$adminPrefix/login` '
              'and use its `access_token` in **Authorize**. Every error is a '
              'Problem Details (RFC 9457) with the S3 error `code` and the '
              '`resource` (bucket or key) it refers to.',
          // Only the admin API: the S3 API is the one AWS documents
          router: WinterRouter(
            routes: [
              Route.parent(
                path: '/$adminPrefix',
                filterConfig: _filters,
                routes: _routes,
              ),
            ],
          ),
        ),
      ),
      Route.swaggerUi(
        key: 'admin.docs',
        specUrl: '/$adminPrefix/openapi.json',
        title: 'Feather IO admin API',
      ),
    ],
  );

  FilterConfig get _filters =>
      [S3BucketNameFilter(), JwtFilter()].toFilterConfig();

  List<Route> get _routes => [
    // For the orchestrator (Docker, Kubernetes, a load balancer): 503 when the
    // database or the volume fail. Public, and never logged when it is up
    Route.health(
      key: healthKey,
      path: '/health',
      checks: {
        'database': di.find<AppDatabase>().ping,
        'storage': di.find<ObjectService>().storageWritable,
      },
    ),
    Route.post(
      key: 'admin.auth.login',
      path: '/login',
      handler: authController.login,
      docs: RouteDocs(
        summary: 'Log in with the root key',
        description:
            'Checks `FEATHER_ACCESS`/`FEATHER_SECRET` and issues a JWT valid '
            'for 12 hours. Every failure waits a second, and 10 failures in a '
            'row lock the IP for 15 minutes.',
        tags: ['Auth'],
        request: BodyDocs(
          example: LoginRequest.example,
          schema: JsonSchema.object(
            {'access': JsonSchema.string(), 'secret': JsonSchema.string()},
            required: ['access', 'secret'],
          ),
        ),
        response: LoginResponse.example,
        responses: {
          403: 'Wrong credentials (`InvalidCredentials`)',
          429: 'Too many failed logins from this IP (`Retry-After`)',
        },
      ),
    ),
    Route.get(
      key: Permissions.adminBucketGet,
      path: '/bucket/{bucket}',
      handler: buckets.getBucket,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminBucketGet)),
        ReservedBucketFilter(),
      ]),
      docs: RouteDocs(
        summary: 'A bucket with its metadata and stats',
        tags: ['Buckets'],
        response: BucketModel.example,
      ),
    ),
    Route.delete(
      key: Permissions.adminBucketEmpty,
      path: '/bucket/{bucket}/objects',
      handler: buckets.emptyBucket,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminBucketEmpty)),
        ReservedBucketFilter(),
      ]),
      docs: const RouteDocs(
        summary: 'Delete every object of a bucket, keeping the bucket',
        tags: ['Buckets'],
        status: 204,
      ),
    ),
    Route.delete(
      key: Permissions.adminBucketDeleteFolder,
      path: '/bucket/{bucket}/folder',
      handler: buckets.deleteFolder,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminBucketDeleteFolder)),
        ReservedBucketFilter(),
      ]),
      docs: RouteDocs(
        summary: 'Delete a folder with all its content',
        description:
            'Through the S3 API, deleting `photos/` only removes the empty '
            'folder (its marker).',
        tags: ['Buckets'],
        status: 204,
        query: [
          QueryParam(
            'prefix',
            JsonSchema.string(minLength: 1),
            required: true,
            description: 'The folder, ending in `/` (`photos/`)',
          ),
        ],
      ),
    ),
    Route.post(
      key: Permissions.adminBucketPresign,
      path: '/bucket/{bucket}/presign',
      handler: buckets.presignObject,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminBucketPresign)),
        ReservedBucketFilter(),
      ]),
      docs: RouteDocs(
        summary: 'A presigned URL to download an object',
        description:
            'Signed with the root key. It points to `PUBLIC_URL` or, without '
            'it, to the host of this request (the host is part of the '
            'signature).',
        tags: ['Buckets'],
        request: PresignRequest.example,
        response: PresignedUrlModel.example,
      ),
    ),
    Route.put(
      key: Permissions.adminBucketUpdate,
      path: '/bucket/{bucket}',
      handler: buckets.updateBucket,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminBucketUpdate)),
        ReservedBucketFilter(),
      ]),
      docs: RouteDocs(
        summary: 'Replace the metadata of a bucket',
        description: 'A missing or null field clears it.',
        tags: ['Buckets'],
        request: UpdateBucketRequest.example,
        response: BucketModel.example,
      ),
    ),
    Route.post(
      key: Permissions.adminBucketDownload,
      path: '/bucket/{bucket}/download',
      handler: buckets.downloadObjects,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminBucketDownload)),
      ]),
      docs: RouteDocs(
        summary: 'Download objects and folders in a zip',
        tags: ['Buckets'],
        request: DownloadObjectsRequest.example,
        response: BodyDocs(
          schema: JsonSchema.string(format: 'binary'),
          contentType: 'application/zip',
        ),
      ),
    ),
    Route.get(
      key: Permissions.adminAnonymousAccessGetRules,
      path: '/bucket/{bucket}/anonymous-access',
      handler: anonymousAccessController.getRules,
      filterConfig: FilterConfig([
        AuthFilter(
          rule: hasPermission(Permissions.adminAnonymousAccessGetRules),
        ),
      ]),
      docs: RouteDocs(
        summary: 'The anonymous access rules of a bucket',
        tags: ['Anonymous access'],
        response: [AnonymousRuleModel.example],
      ),
    ),
    Route.post(
      key: Permissions.adminAnonymousAccessWriteRule,
      path: '/bucket/{bucket}/anonymous-access',
      handler: anonymousAccessController.createRule,
      filterConfig: FilterConfig([
        AuthFilter(
          rule: hasPermission(Permissions.adminAnonymousAccessWriteRule),
        ),
      ]),
      docs: RouteDocs(
        summary: 'Create or replace the rule of a prefix',
        description:
            'A prefix without `*` opens every key that starts with it; with '
            '`*` (any characters, `/` included) the whole key must match.',
        tags: ['Anonymous access'],
        request: CreateRuleRequest.example,
        response: AnonymousRuleModel.example,
      ),
    ),
    Route.delete(
      key: Permissions.adminAnonymousAccessDeleteRule,
      path: '/bucket/{bucket}/anonymous-access',
      handler: anonymousAccessController.deleteRule,
      filterConfig: FilterConfig([
        AuthFilter(
          rule: hasPermission(Permissions.adminAnonymousAccessDeleteRule),
        ),
      ]),
      docs: RouteDocs(
        summary: 'Delete the rule of a prefix',
        tags: ['Anonymous access'],
        request: DeleteRuleRequest.example,
      ),
    ),
    Route.get(
      key: Permissions.adminAccessKeyList,
      path: '/access-keys',
      handler: accessKeyController.list,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminAccessKeyList)),
      ]),
      docs: RouteDocs(
        summary: 'The root key and the managed access keys',
        tags: ['Access keys'],
        response: AccessKeyListModel.example,
      ),
    ),
    Route.post(
      key: Permissions.adminAccessKeyCreate,
      path: '/access-keys',
      handler: accessKeyController.create,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminAccessKeyCreate)),
      ]),
      docs: RouteDocs(
        summary: 'Create an access key',
        description:
            'Its `secret_access_key` is only in this response (and in the one '
            'of regenerating it).',
        tags: ['Access keys'],
        status: 201,
        request: AccessKeyRequest.example,
        response: AccessKeyModel.example,
      ),
    ),
    Route.put(
      key: Permissions.adminAccessKeyUpdate,
      path: '/access-keys/{id}',
      handler: accessKeyController.update,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminAccessKeyUpdate)),
      ]),
      docs: RouteDocs(
        summary: 'Update an access key',
        tags: ['Access keys'],
        request: AccessKeyRequest.example,
        response: AccessKeyModel.example.withoutSecret(),
      ),
    ),
    Route.post(
      key: Permissions.adminAccessKeyRegenerateSecret,
      path: '/access-keys/{id}/secret',
      handler: accessKeyController.regenerateSecret,
      filterConfig: FilterConfig([
        AuthFilter(
          rule: hasPermission(Permissions.adminAccessKeyRegenerateSecret),
        ),
      ]),
      docs: RouteDocs(
        summary: 'Give an access key a new secret',
        description: 'The old secret stops working at once.',
        tags: ['Access keys'],
        response: AccessKeyModel.example,
      ),
    ),
    Route.delete(
      key: Permissions.adminAccessKeyDelete,
      path: '/access-keys/{id}',
      handler: accessKeyController.delete,
      filterConfig: FilterConfig([
        AuthFilter(rule: hasPermission(Permissions.adminAccessKeyDelete)),
      ]),
      docs: const RouteDocs(
        summary: 'Delete an access key',
        tags: ['Access keys'],
        status: 204,
      ),
    ),
  ];
}
