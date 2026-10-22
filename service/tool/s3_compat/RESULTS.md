# Test results (full run from scratch)

Run on **2026-10-22** on commit `8304b48` (`feature/audit_fixes`) with uncommitted changes,
on Windows 11 with Docker version 29.4.1, build 055a478.
Generated with `service/tool/s3_compat/report.py`; to repeat it, see *Full test run* in `CLAUDE.md`.

| What                                | Result                                                                                                                                             |
|-------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `dart analyze` (service)            | No issues                                                                                                                                          |
| `flutter analyze` (console)         | 1 issue (see the output)                                                                                                                           |
| `dart test` (service)               | **548/548** in 42 files                                                                                                                            |
| `flutter test` (console)            | **142/142** in 20 files                                                                                                                            |
| AWS CLI v2 (`aws-cli/2.37.9`)       | **34/34**                                                                                                                                          |
| rclone (`rclone v1.75.1`)           | **19/19**                                                                                                                                          |
| MinIO Mint (15 suites)              | No failures: `aws-sdk-java`, `aws-sdk-java-v2`, `s3cmd`. Finish with out-of-scope failures: `minio-go`, `minio-java`. Unclassified failures: **0** |
| Unhandled errors in the service log | **0**                                                                                                                                              |

## 1. Service tests (`dart test`)

| File                                |   Tests | What it covers                                                                                                                                                                                                                                                                                       |
|-------------------------------------|--------:|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `access_keys_permissions_test.dart` | 112/112 | Access key permission matrix (every S3 operation for read, write and both, on its bucket and another), keys on every bucket, multipart, presigned URLs, changes taking effect, edge cases (tampered secret, recreated bucket, console login), and anonymous rules applying to signed keys as in AWS. |
| `access_keys_test.dart`             |   23/23 | Access keys: admin CRUD and validation (422 per nested field, 400 naming the field), encrypted secret, each level on its bucket, ListBuckets filtered, copies, disabled/expired/deleted keys, regenerating the secret.                                                                               |
| `anonymous_access_test.dart`        |   32/32 | Anonymous access rules (admin CRUD, effect on list/get/put/delete, a prefix without `*` and the whole key with `*`, listings only through rules that cover longer keys, folder keys with their `/`) and multipart never being anonymous.                                                             |
| `aws_chunked_test.dart`             |   10/10 | `aws-chunked` bodies (chunk signatures and trailers), lines split mid-way, errors, and a failed upload not overwriting the object.                                                                                                                                                                   |
| `body_size_test.dart`               |     8/8 | Size limits: objects > 10 MB (`EntityTooLarge`), 2 MB bodies, chunked without `Content-Length`.                                                                                                                                                                                                      |
| `copy_object_test.dart`             |   18/18 | CopyObject: copies, across buckets, onto itself, a folder as the target, errors and the `x-amz-copy-source-if-*` conditions.                                                                                                                                                                         |
| `cors_test.dart`                    |     3/3 | CORS (preflight and the exposed `ETag`).                                                                                                                                                                                                                                                             |
| `create_bucket_test.dart`           |   11/11 | CreateBucket: JWT and SigV4, no body nor `Content-Length`, metadata, validation and reserved names.                                                                                                                                                                                                  |
| `create_folder_test.dart`           |   14/14 | Folders (`key/`): create, list, HEAD/GET and S3-like deletion (only the marker).                                                                                                                                                                                                                     |
| `database_path_test.dart`           |     3/3 | SQLite file inside `STORAGE_VOLUME_PATH/.db/`, not listed as a bucket.                                                                                                                                                                                                                               |
| `delete_bucket_test.dart`           |     7/7 | DeleteBucket: empty, not empty, missing, reserved, SigV4.                                                                                                                                                                                                                                            |
| `delete_folder_test.dart`           |     7/7 | Admin endpoint to delete a folder with its content.                                                                                                                                                                                                                                                  |
| `delete_object_test.dart`           |   17/17 | DeleteObject and DeleteObjects (JSON and S3 XML), parallel deletes and the retry on Windows.                                                                                                                                                                                                         |
| `empty_bucket_test.dart`            |     5/5 | Admin endpoint to empty a bucket.                                                                                                                                                                                                                                                                    |
| `extended_env_test.dart`            |     2/2 | Configuration (unit): the warning for secrets shorter than recommended.                                                                                                                                                                                                                              |
| `get_bucket_location_test.dart`     |     4/4 | GetBucketLocation (`?location`).                                                                                                                                                                                                                                                                     |
| `get_bucket_test.dart`              |     6/6 | Bucket details (admin): metadata and statistics.                                                                                                                                                                                                                                                     |
| `get_object_test.dart`              |   34/34 | GET/HEAD: content types, ETag, `Range` (206/416), `response-*` overrides, conditional requests (304/412), `CSP: sandbox` on HTML/SVG/XML.                                                                                                                                                            |
| `health_test.dart`                  |     4/4 | Health check of the admin API: public, `application/health+json` `pass` with the database and storage checks, `HEAD`, no probe file left, `503` when the database is down.                                                                                                                           |
| `i18n_test.dart`                    |     8/8 | Localized errors: English by default, `Accept-Language: es` in XML and JSON with the same code and `Vary`, regions and q-values, 422 rules of Winter and the service, login.                                                                                                                         |
| `list_buckets_test.dart`            |     8/8 | ListBuckets: JSON/XML, UTC dates, `Owner`, statistics.                                                                                                                                                                                                                                               |
| `list_objects_test.dart`            |   29/29 | ListObjects V1 and V2: prefixes, paging (token, `marker`, `start-after`), ETags, `encoding-type=url`.                                                                                                                                                                                                |
| `login_rate_limit_test.dart`        |     3/3 | Login attempt limit against the server: 429 with `Retry-After`, fake `X-Forwarded-For`, end of the lock, requests that hold back their bodies.                                                                                                                                                       |
| `login_rate_limiter_test.dart`      |     6/6 | Login attempt limit (unit, fake clock): penalty, lock, unlock and reset.                                                                                                                                                                                                                             |
| `login_test.dart`                   |     9/9 | Console login (JWT) and tampered tokens: no `exp`, expired, another secret, `alg: none`; a malformed body names its field; errors without internal details.                                                                                                                                          |
| `multipart_test.dart`               |   33/33 | Multipart: create, parts, complete, abort, ListMultipartUploads, ListParts, UploadPartCopy, a retried Complete and a part uploaded twice at once.                                                                                                                                                    |
| `object_meta_table_repo_test.dart`  |     1/1 | Object metadata table (unit): deleting the rows of a folder whose name has an emoji.                                                                                                                                                                                                                 |
| `object_metadata_test.dart`         |   13/13 | Metadata: `Content-Type`, `x-amz-meta-*`, storage class, on copies and multipart, parallel PUTs of a key.                                                                                                                                                                                            |
| `openapi_test.dart`                 |     5/5 | OpenAPI document of the admin API (every route, no S3 routes, Bearer security, constraints from `validate()`) and Swagger UI.                                                                                                                                                                        |
| `presign_public_url_test.dart`      |     5/5 | Presigned URLs with `PUBLIC_URL`: public domain even with a tampered `Host`, valid through a proxy, and validation of the variable.                                                                                                                                                                  |
| `presign_test.dart`                 |   11/11 | Presigned URLs (admin endpoint and SigV4 query verification).                                                                                                                                                                                                                                        |
| `put_object_test.dart`              |   18/18 | PutObject: uploads, ETag, missing bucket, key validation (`..` inside a name, empty segments), path traversal, replacing an open object (Windows), a key and a folder with the same name (409).                                                                                                      |
| `rate_limit_test.dart`              |     6/6 | General limit per IP: `RateLimit` headers, `503 SlowDown` on S3 and 429 on admin with `Retry-After`, fake `X-Forwarded-For`, next window.                                                                                                                                                            |
| `s3_controller_test.dart`           |     5/5 | Full happy path (create bucket → upload → list → download → delete).                                                                                                                                                                                                                                 |
| `s3_error_test.dart`                |   24/24 | S3 errors in XML/JSON and SigV4 signatures: wrong signature and key, replay (±15 min), credential date, body sha256, presigned URL dated in the future, unsigned `x-amz-*` headers.                                                                                                                  |
| `s3_validator_test.dart`            |     5/5 | Key validation (unit): folders, `..` inside a name, `..`/`.`/empty segments, names ending in a dot or space on Windows.                                                                                                                                                                              |
| `secret_cipher_test.dart`           |     5/5 | AES-GCM encryption of the access key secrets: round trip, nonce, key id, passphrase and tampering.                                                                                                                                                                                                   |
| `sig_v4_signer_test.dart`           |     3/3 | SigV4 signature against the official example of the AWS docs.                                                                                                                                                                                                                                        |
| `storage_cleanup_test.dart`         |     2/2 | Storage cleanup: temp files older than a day and multipart uploads older than a week.                                                                                                                                                                                                                |
| `unsupported_subresource_test.dart` |     9/9 | `501 NotImplemented` for subresources and the reads that are answered anyway (tagging, versioning).                                                                                                                                                                                                  |
| `update_bucket_test.dart`           |   11/11 | Editing the description and color of a bucket (admin).                                                                                                                                                                                                                                               |
| `xml_test.dart`                     |     9/9 | XML mapper (unit): writing with escaping and indentation, reading S3 bodies with prefixes, CDATA and entities, malformed XML, the nesting limit.                                                                                                                                                     |

## 2. Console tests (`flutter test`)

Cubits, repos and models, on the VM.

| File                               | Tests | What it covers                                                                                                                                           |
|------------------------------------|------:|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `access_key_cubit_test.dart`       |   9/9 | Access keys section: load, search and filters, enable/disable, regenerate, delete, buckets deleted elsewhere.                                            |
| `access_key_filter_test.dart`      |   7/7 | Access key filter: status, level and bucket groups and how they combine.                                                                                 |
| `access_key_form_cubit_test.dart`  |   4/4 | Access key drawer: create (secret shown), edit, 422 per field, general error.                                                                            |
| `access_key_repo_test.dart`        |   5/5 | Access key DTO mapping (grants, levels, root id, secret), requests with UTC expiry, API errors.                                                          |
| `anonymous_access_cubit_test.dart` |   9/9 | Anonymous rules of a bucket: load, stale responses of another bucket, delete; add-rule form with 422.                                                    |
| `anonymous_access_repo_test.dart`  |   3/3 | Anonymous rule mapping and requests, API errors.                                                                                                         |
| `auth_test.dart`                   | 10/10 | Session: JWT and expiry saved (never the keys), restore, expired or broken session, login and logout.                                                    |
| `browser_cubit_test.dart`          | 17/17 | Object browser: listing, paging with tokens, refresh, page size, up/forward, delete, changes from other sections, a slow answer of a folder left behind. |
| `browser_repo_test.dart`           |   5/5 | Listing mapping, objects vs folders on delete, presigned link expiry, API errors.                                                                        |
| `bucket_cubit_test.dart`           |   7/7 | Bucket list: load, delete and empty with bus notices, changes from other sections.                                                                       |
| `bucket_form_cubit_test.dart`      |   5/5 | Bucket drawer: create, edit, 422 per field, 409 on the name.                                                                                             |
| `bucket_repo_test.dart`            |   4/4 | Bucket mapping and create/update requests, API errors.                                                                                                   |
| `object_action_cubit_test.dart`    |   5/5 | Create folder, rename, move (also failing halfway) and their bus notices.                                                                                |
| `object_dialogs_cubit_test.dart`   | 11/11 | Move target folders, object details with thumbnail, shared link expiry and stale responses.                                                              |
| `object_models_test.dart`          | 13/13 | Object name validation, the type/size/date filters and the type a preview opens with.                                                                    |
| `route_config_test.dart`           |   4/4 | Where to go after login: only internal paths (open redirect).                                                                                            |
| `transfer_client_test.dart`        |   4/4 | Uploads send the Content-Type of the key, not the JSON default of Dio, and the key encoded in the URL.                                                   |
| `transfer_cubit_test.dart`         | 13/13 | Transfer queue: 2 at a time, bucket notices, retry, cancel, progress, multipart parts and abort, zip downloads.                                          |
| `transfer_repo_test.dart`          |   4/4 | Cancelling a transfer, multipart parts sent to complete, API errors.                                                                                     |
| `zip_file_name_test.dart`          |   3/3 | Name of a zip download.                                                                                                                                  |

## 3. Real clients: AWS CLI v2 and rclone

Scripts `awscli.sh` and `rclone.sh` (see the scripts for what each step checks). Every step
that downloads something also compares the content.

| Client                        | Steps | Failing |
|-------------------------------|------:|---------|
| AWS CLI v2 (`aws-cli/2.37.9`) | 34/34 | —       |
| rclone (`rclone v1.75.1`)     | 19/19 | —       |

## 4. MinIO Mint

Each suite tests with one SDK or tool. Many stop at their first failure; NA are tests the
suite itself skips. `aws-sdk-java`, `aws-sdk-java-v2` and `minio-go` only log failures and
skipped tests: that they pass is known from their exit code (*Finishes OK*).

| Suite             | Finishes OK |   ✅ |   ❌ |  NA | Status                                                                                          |
|-------------------|:-----------:|----:|----:|----:|-------------------------------------------------------------------------------------------------|
| `awscli`          |      ❌      |  10 |   1 |   0 | Stops at `s3 presign` (SigV2, from CLI v1).                                                     |
| `aws-sdk-go`      |      ❌      |   0 |   1 |   0 | Stops at the first test: it expects a presigned URL to verify an `x-amz-content-sha256` header. |
| `aws-sdk-java`    |      ✅      |   — |   0 |   0 | Passes entirely.                                                                                |
| `aws-sdk-java-v2` |      ✅      |   — |   0 |   0 | Passes entirely.                                                                                |
| `aws-sdk-php`     |      ❌      |  11 |   1 |   0 | Stops when aborting a missing upload (MinIO behavior).                                          |
| `aws-sdk-ruby`    |      ❌      |  12 |   1 |   0 | Stops at POST policy.                                                                           |
| `minio-go`        |      ✅      |   — |   1 |   1 | Passes entirely with SigV4; the SigV2 part gets 401.                                            |
| `minio-py`        |      ❌      |  10 |   1 |   6 | Stops at snowball (a MinIO API).                                                                |
| `minio-js`        |      ❌      | 195 |  13 |   0 | Reaches the end with isolated failures (each block goes on after a failure).                    |
| `minio-java`      |      ✅      |  27 |  11 |  32 | Reaches the end with isolated failures.                                                         |
| `mc`              |      ❌      |  15 |   1 |   0 | Stops at POST policy.                                                                           |
| `s3cmd`           |      ✅      |   8 |   0 |   0 | Passes entirely.                                                                                |
| `healthcheck`     |      ❌      |   0 |   1 |   0 | Out of scope: MinIO health endpoints.                                                           |
| `s3select`        |      ❌      |   0 |   1 |   0 | Out of scope: S3 Select.                                                                        |
| `versioning`      |      ❌      |   0 |   1 |   0 | Out of scope: versioning.                                                                       |

### Failures and their cause

| Suite          | Test                                                                                       | Cause                                                                                                  |
|----------------|--------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| `awscli`       | aws --endpoint-url http://host.docker.internal:8080 s3 presign s3://awscli-mint-test-buck… | Out of scope: CLI v1 signs `s3 presign` with SigV2.                                                    |
| `aws-sdk-go`   | PresignedPut                                                                               | Out of scope: `x-amz-content-sha256` is not verified on presigned URLs (it is with header signatures). |
| `aws-sdk-php`  | abortMultipartupload ( array $params = [] )                                                | MinIO behavior: aborting a missing upload gives 204; AWS S3 (and feather-io) give 404 `NoSuchUpload`.  |
| `aws-sdk-ruby` | presignedPost(bucket_name,file_name,expires_in_sec,max_byte_size)                          | Out of scope: POST policy uploads.                                                                     |
| `minio-go`     | MakeBucket(bucketName, location)                                                           | Out of scope: SigV2 signatures.                                                                        |
| `minio-py`     |                                                                                            | Out of scope: snowball is a MinIO API.                                                                 |
| `minio-js`     | presignedPostPolicy(postPolicy, cb)                                                        | Out of scope: POST policy uploads.                                                                     |
| `minio-js`     | presignedPostPolicy(postPolicy, cb)                                                        | Out of scope: POST policy uploads.                                                                     |
| `minio-js`     | listObjects(bucketName, prefix, recursive)                                                 | Knock-on: `datafile-1-b` stays, the POST policy tests (out of scope) delete it.                        |
| `minio-js`     | listenBucketNotification(bucketName, prefix, suffix, events)                               | Out of scope: notifications (minio-java also repeats the `events` query parameter; see the notes).     |
| `minio-js`     | putObjectRetention(bucketName, objectName, putOpts)                                        | Out of scope: retention / object lock.                                                                 |
| `minio-js`     | putObject(bucketName, objectName, stream)                                                  | Limitation: keys with `<>:"\|?*`, which the filesystem (Windows) does not support.                     |
| `minio-js`     | putObject(bucketName, objectName, stream)                                                  | Limitation: keys with `<>:"\|?*`, which the filesystem (Windows) does not support.                     |
| `minio-js`     | putObject(bucketName, objectName, stream)                                                  | Limitation: keys with `<>:"\|?*`, which the filesystem (Windows) does not support.                     |
| `minio-js`     | selectObjectContent(bucketName, objectName, selectOpts)                                    | Out of scope: S3 Select.                                                                               |
| `minio-js`     | "after all" hook for "Remove Object post select of content:                                | Knock-on: the S3 Select bucket isn't emptied.                                                          |
| `minio-js`     | listObjects(bucketName, prefix, recursive)                                                 | Knock-on: MinIO's own prefix force-delete.                                                             |
| `minio-js`     | "after all" hook in "Force Deletion of prefix"                                             | Knock-on: MinIO's own prefix force-delete.                                                             |
| `minio-js`     | "after all" hook in "functional tests"                                                     | Knock-on: the main bucket keeps objects from tests that failed before.                                 |
| `minio-java`   | listenBucketNotification()                                                                 | Out of scope: notifications (minio-java also repeats the `events` query parameter; see the notes).     |
| `minio-java`   | getPresignedPostFormData()                                                                 | Out of scope: POST policy uploads.                                                                     |
| `minio-java`   | uploadSnowballObjects()                                                                    | Out of scope: snowball is a MinIO API.                                                                 |
| `minio-java`   | uploadSnowballObjects()                                                                    | Out of scope: snowball is a MinIO API.                                                                 |
| `minio-java`   | removeBucket()                                                                             | Knock-on: the snowball bucket isn't emptied.                                                           |
| `minio-java`   | addUser()                                                                                  | Out of scope: MinIO admin API.                                                                         |
| `minio-java`   | addCannedPolicy()                                                                          | Out of scope: MinIO admin API.                                                                         |
| `minio-java`   | setPolicy()                                                                                | Out of scope: MinIO admin API.                                                                         |
| `minio-java`   | getUserInfo()                                                                              | Out of scope: MinIO admin API.                                                                         |
| `minio-java`   | listUsers()                                                                                | Out of scope: MinIO admin API.                                                                         |
| `minio-java`   | listCannedPolicies()                                                                       | Out of scope: MinIO admin API.                                                                         |
| `mc`           | test_presigned_post_policy_error                                                           | Out of scope: POST policy uploads.                                                                     |
| `healthcheck`  | testLivenessEndpoint                                                                       | Out of scope: MinIO's own health endpoint.                                                             |
| `s3select`     | select_object_content(bucket_name, object_name, request)                                   | Out of scope: S3 Select.                                                                               |
| `versioning`   | /mint/build/versioning/bucket.go:66: main.testMakeBucket                                   | Out of scope: versioning.                                                                              |

## 5. What doesn't work

**Out of scope** (under *Parked* in `ROADMAP.md`; they answer `501 NotImplemented` or 401)

- SigV2 signatures (including `aws s3 presign` from CLI v1).
- Verifying checksums (`Content-MD5`, the `aws-chunked` CRC, each chunk's signature) and
  `x-amz-content-sha256` on presigned URLs (it is verified with header signatures).
- POST policy uploads (presigned forms).
- Versioning (only answered as never enabled) and tags (only answered as none).
- Bucket policies, ACLs, encryption, lifecycle, per-bucket CORS, website, logging, replication.
- Notifications, S3 Select, retention / object lock / legal hold.
- MinIO's own APIs: admin, health, snowball, prefix force-delete.
- Keys with characters the filesystem doesn't support (`<>:"|?*` on Windows).

**Notes**

- The SigV4 canonical query keeps a single value per parameter: a signed request that repeats a
  parameter (`events=…&events=…`, only MinIO's `listenBucketNotification` does) gets
  `SignatureDoesNotMatch`.
- The php test that aborts a missing upload expects MinIO's behavior; feather-io follows AWS S3.
- On Windows, replacing an object another request keeps open is retried for 5 s and then answers
  `503 ServiceUnavailable` (clients retry it). It doesn't happen on Linux.

## 6. What isn't tested

- **Linux**: the service of these runs is on Windows; production runs the `Dockerfile` image on
  Linux.
- **HTTPS**: every test goes over HTTP.
- **Virtual-hosted style** (`bucket.host`): path-style only.
- **High load and concurrency**: only the concurrency the clients add themselves (parallel uploads
  and deletes).
- **Console screens**: its tests cover cubits, repos and models on the VM, not the widgets nor
  the browser-only adapters (`*_web.dart`).
- **Other clients**: Cyberduck, s3fs, the .NET and Rust SDKs, boto3 directly (the AWS CLI and s3cmd
  use it underneath).
