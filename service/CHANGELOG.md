# Changelog

## 1.0.0-rc.7 (2026-10-25)

- Winter `1.0.0-rc.6`. The route table logged at start-up was a single line full of `\n` and
  `\x1b` escapes; now it is one line per route (method, path, key and filters) between the
  `Routes log start` and `Routes log end` lines. `S3BucketNameFilter` shows its name there.

## 1.0.0-rc.6 (2026-10-22)

Fixes from a security audit and a code audit.

- Winter `1.0.0-rc.5`. The admin API only reads a JSON body with a JSON `Content-Type`
  (`application/json`): a body sent as `text/plain` or without `Content-Type` is now a `415`, so a
  page of another site can't post it without a CORS preflight. The console already sends it.
- Admin API responses carry `Cache-Control: private`; S3 responses still carry only the
  `Cache-Control` stored with the object, as in S3.
- Security:
  - SigV4 rejects a request with an `x-amz-*` header that is not signed (`AccessDenied`), as S3
    does: a presigned PUT URL plus an unsigned `x-amz-copy-source` copied any object the signer
    could read. `x-amz-content-sha256` and the ACL headers (ignored) may stay unsigned.
  - The login lock is checked again once the body is read: requests that held back their bodies
    each got a guess past it.
  - An anonymous rule with `*` only opens a listing if it ends in `*` (`photos/*.jpg` listed
    `photos/a.jpg.zip` through the prefix `photos/a.jpg`), and object routes match the rule
    against the key with its trailing `/` (a write rule no longer creates or deletes folders it
    doesn't cover).
  - HTML, SVG and XML objects are sent with `Content-Security-Policy: sandbox`.
  - A bucket created again doesn't inherit the access key grants and anonymous rules left with its
    name.
  - A warning at start-up when `FEATHER_SECRET` has fewer than 16 characters, or `JWT_SECRET` or
    `KEYS_ENCRYPTION_SECRET` fewer than 32 (it still starts).
  - The XML parser accepts at most 64 nested elements (a deeper body is `MalformedXML`, not a
    stack overflow).
- Keys: `..` inside a name is allowed (`report..final.pdf`); a `..`, `.` or empty segment
  (`a//b`, `a/./b`) is `InvalidArgument`, and on Windows so is a name ending in a dot or a space.
- A key and a folder with the same name (`docs/readme` when `docs` is an object, or `docs` when
  `docs/` holds objects) answer `409 KeyConflict` instead of 500, without leaving the temp file.
- Two `CompleteMultipartUpload` of the same upload at once (a client that retries) answer the same
  instead of corrupting the object, and a part uploaded twice at once keeps its file and ETag
  together.
- Two PUTs of the same key at once can no longer leave an ETag and headers that don't match the
  content.
- CopyObject keeps the trailing `/` of the target key, so a copy to a folder is rejected.
- Once a day (and at start-up) the service deletes the temp files of `.tmp/` older than a day and
  aborts the multipart uploads started more than 7 days ago.
- Deleting a folder whose name has an emoji deletes the metadata of its objects.
- `pubspec.lock` is committed; the Docker image resolves with `--enforce-lockfile`.

## 1.0.0-rc.5 (2026-10-19)

- Winter `1.0.0-rc.3`. JSON errors carry the `instance` (the path of the request) of RFC 9457, and
  `422` is titled `Unprocessable Content` (RFC 9110).
- The rate limit headers follow the IETF draft: `RateLimit-Policy` and `RateLimit` replace
  `X-RateLimit-*`.
- `GET /{admin}/health` answers `application/health+json`: `"status": "pass"`/`"fail"`, with a list
  per check (it was `UP`/`DOWN`). Update the probes that read the body; the status codes don't change.
- GetObject honours the conditional headers: `If-None-Match`/`If-Modified-Since` give `304`, a
  failed `If-Match`/`If-Unmodified-Since` gives `412 PreconditionFailed`.
- `TRUSTED_PROXIES` also takes the public scheme of the request from `X-Forwarded-Proto` (presigned
  URLs without `PUBLIC_URL`), and an IPv6 client counts by its /64 in the rate limits.

## 1.0.0-rc.4 (2026-10-15)

- No changes; released with the console's fix of the SVG preview.

## 1.0.0-rc.3 (2026-10-13)

- No changes; released with the console's fix of the `Content-Type` of uploads.

## 1.0.0-rc.2 (2026-10-11)

- The Docker image no longer declares a `VOLUME`: platforms that mount their own (Railway)
  reject it. Mount one at `/data` (`STORAGE_VOLUME_PATH`) as before.

## 1.0.0-rc.1 (2026-10-10)

First release candidate of the S3-compatible service.

- **S3 API**: buckets (create, list, delete, location), objects (upload streamed to disk, download
  with `Range`, `HEAD`, copy with conditions, delete one or up to 1000, folders, stored headers and
  storage class, real ETags), ListObjects V1 and V2 (prefix, delimiter, paging,
  `encoding-type=url`) and multipart (create, parts, copy of parts, complete, abort, list parts and
  uploads). XML like S3 by default, JSON with `Accept: application/json`; unimplemented
  subresources answer `501 NotImplemented`.
- **Authentication**: AWS SigV4 in the header and in presigned URLs (up to 7 days), `aws-chunked`
  bodies, clock skew and body sha256 checks; JWT for the console.
- **Access**: managed access keys (read, write or both, per bucket or on every bucket, expiry,
  secrets encrypted with AES-256-GCM) and anonymous access rules per prefix or pattern.
- **Admin API** for the console: bucket details and statistics, empty a bucket, delete a folder,
  presigned links, zip downloads, anonymous rules and access keys; documented with OpenAPI and
  Swagger UI.
- **Operations**: health check at `/{admin}/health`, structured logs (`LOG_FORMAT=json`), a rate
  limit per IP and login throttling, error messages in English and Spanish, metadata in SQLite (WAL)
  inside the storage volume, and a 24 MB Docker image.
- Tested against the AWS CLI v2, rclone and the 15 suites of MinIO Mint.
