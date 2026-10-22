# Roadmap

Where `service/` and `console/` stand and the work that remains, in order. Mark each task with
`[x]` when it is done.

## Current status

| Area             | Service                                                                                                                       | Console                                                          |
|------------------|-------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| Buckets          | List, create, edit, delete, empty, details with statistics (description and color in SQLite)                                  | All of the above, in the *Buckets* section                       |
| Objects          | List (prefix/delimiter, paging), upload, multipart, download, copy, delete one or many, zip download, folders, presigned URLs | All of the above, with preview, drag & drop and a transfer queue |
| Anonymous access | Rules per prefix or pattern (`readOnly`, `writeOnly`, `readWrite`), applied by `AnonymousAccessFilter`                        | Create and delete rules per bucket                               |
| Auth             | JWT + SigV4, the root key from the env plus access keys per bucket, login and general rate limits                             | Login, *Access keys* section                                     |
| Operations       | Health check, structured logs, OpenAPI, Docker image, CI                                                                      | Docker image on nginx; `docker-compose.yml` for both             |

## Assessment

Where the service stands (2026-10-10), from 1 to 10, as a lightweight self-hosted S3 storage, not
against MinIO or AWS as products:

| Area                  |  Score  | Why                                                                                                                                                                                                                                                                                                                                                                                                    |
|-----------------------|:-------:|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| S3 compatibility      |  **9**  | AWS CLI 34/34 and rclone 19/19; every Mint failure is something out of scope (SigV2, versioning, POST policy, S3 Select…), none of what it supports. Fine details covered: `aws-chunked`, `encoding-type=url`, ranges, copy conditions, full multipart                                                                                                                                                 |
| Security              | **8.5** | SigV4 with clock skew and body sha256, access keys encrypted with AES-GCM, login throttling, rate limit, errors without internal details, path traversal. Missing: its own TLS (it relies on a proxy) and an external audit                                                                                                                                                                            |
| Tests                 | **8.5** | About as many lines of tests as of code (~500 service tests, 132 console tests, the batteries against real clients), all run by CI on the main branches and their pull requests except Mint                                                                                                                                                                                                            |
| Architecture and code |  **8**  | Clear layers, features like `admin/`, XML apart, Problem Details errors, `DECISIONS.md`. `ObjectService` is still big (~650 lines)                                                                                                                                                                                                                                                                     |
| Performance           | **7.5** | Very light on memory (12 MiB at start); uploads as fast as MinIO or faster since SQLite runs in WAL mode (2037 PUTs/s of 1 KiB, MinIO 1040), and a listing page costs what its folder holds (25 ms with 1000 objects, 67 ms with 10 000). Still behind: reads of small objects (a third of MinIO), big single uploads, and ListBuckets walking the whole storage (`service/tool/benchmark/RESULTS.md`) |
| Production readiness  |  **6**  | 24 MB Docker image, structured logs, graceful shutdown, OpenAPI, CI, a health check, backups documented. Missing: metrics, real long-running use; it depends on a release candidate of Winter                                                                                                                                                                                                          |

Overall **8**. Within its scope it can reach **8.5–9**; a 10 would need what it isn't by design
(several nodes, replication, versioning). The cheap improvements with the best return are done
(listings that only walk their folder, SQLite in WAL, CI, health check and backups); the next one
is **ListBuckets and listings from an index in SQLite** (*After 1.0*), only needed for buckets of
tens of thousands of objects.

## Done for 1.0

- **S3 API**: buckets, objects (streamed uploads, `Range`, copies with conditions, multi-delete,
  folders, stored headers and storage class, real ETags), ListObjects V1/V2 with paging and
  `encoding-type=url`, full multipart, presigned URLs, `aws-chunked`, `501` for the unimplemented
  subresources. Verified against the AWS CLI, rclone and MinIO Mint (`service/tool/s3_compat/`).
- **Access**: SigV4 and JWT, managed access keys per bucket (encrypted secrets), anonymous rules
  per prefix or pattern, login throttling and a general rate limit.
- **Admin API**: bucket details, empty a bucket, delete a folder, presign, zip downloads, rules and
  keys; Problem Details errors in English and Spanish; OpenAPI with Swagger UI.
- **Console**: browser (list/grid, paging, filters, previews, details, folders, rename/move, share
  links, state in the URL), background transfer queue, *Buckets* section, *Access keys* section.
- **Code and operations**: an XML mapper of its own, `S3Controller` split by operation, metadata in
  SQLite (WAL) inside the volume, benchmarks with warp, health check, structured logs, Docker images
  for both packages and `docker-compose.yml`, CI on GitHub Actions, Winter `1.0.0-rc.1` from
  pub.dev.
- **Open source release**: README, `LICENSE` (Apache 2.0, one for the whole repo),
  `CONTRIBUTING.md`, `SECURITY.md`, changelogs and versions `1.0.0-rc.1`.

## Before 1.0

- [x] A visual identity and icon ([`docs/brand.md`](docs/brand.md)).
- [x] Use the icon in the console: favicon, web icons, splash and `assets/app/app_icon.png`.

## Prepare release

- [x] Merge the branches: `feature/poc` into `develop`, and `develop` into `main`.
- [x] Set the version as release candidate 1, `1.0.0-rc.1`: the same in both `pubspec.yaml`, both
  changelogs and the Docker image tags, and the `v1.0.0-rc.1` tag on `main`.
- [x] A Railway template: the service (with its volume at `/data`) and the console, with the
  variables of `.env.example`.

## Security and robustness issues (audit of 2026-10-21)

Found by a security audit and a code audit of `0c1c3b2`. Every fix comes with its test, keeps S3
compatibility and updates the console if the API changes.

- Security, confirmed:
    - [x] SigV4 accepts unsigned `x-amz-*` headers: a presigned PUT URL (or a captured signed PUT)
      plus an unsigned `x-amz-copy-source` copies any object the signer can read. Reject every
      `x-amz-*` header that is not in `SignedHeaders` (but `x-amz-content-sha256`), as S3 does.
    - [x] The login lock is checked before the body is read: requests whose bodies are held back all
      get their guess past the lock. Check it again after reading the body.
    - [x] An anonymous glob rule that doesn't end in `*` (`photos/*.jpg`) lets anyone list the keys
      it doesn't cover (`?prefix=photos/cat.jpg` shows `photos/cat.jpg.zip`).
    - [x] `AnonymousAccessFilter` matches the key without its trailing `/` while the handler acts on
      the folder key: an anonymous writer creates or deletes folder markers outside the rule.
- Security, to validate:
    - [x] The console's preview opens the object as a `blob:` (console origin) with the uploader's
      `Content-Type`: an HTML or SVG uploaded by an anonymous writer could run script next to the
      root JWT. Preview only inert types (the rest as text or download); the CSP in nginx goes
      with the security headers of the hardening below.
    - Hardening:
        - [x] A warning at start-up for a short `JWT_SECRET`/`FEATHER_SECRET`/
          `KEYS_ENCRYPTION_SECRET` (not an error, so existing deployments keep starting).
        - [x] `Content-Security-Policy: sandbox` on object GETs of HTML, SVG and XML.
        - [x] A depth limit in the XML parser.
        - [x] Keys with empty or `.` segments (`a//b`) rejected.
        - [x] Security headers in the console's nginx, with a CSP.
        - [x] Keys encoded in the console's URLs (`#`, `%`).
        - [x] A bucket created again doesn't inherit the grants and rules left by one of the same
          name (a delete that failed after removing the folder): `createBucket` clears them.
        - [x] The `pubspec.lock` files committed (`--enforce-lockfile` in CI and the Dockerfiles) and
          the CI actions pinned by SHA.
- Robustness:
    - [x] Two CompleteMultipartUpload of the same upload at once (a client that retries) write the
      same `object.tmp` and corrupt the object; UploadPart of the same part shares `<n>.part.tmp`.
    - [x] Two PUTs of the same key at once can save the ETag and headers of one with the size and
      mtime of the other, so they never get recomputed.
    - [x] A key that collides with a folder (`docs` and `docs/readme`) answers 500 (503 on Windows)
      and leaves its temp file behind.
    - [x] `.tmp/` and abandoned multipart uploads are never cleaned up.
    - [x] The console can show a folder other than the one in the URL when two listings cross.
    - [x] CopyObject ignores the trailing `/` of the destination key.
    - [x] Keys with `..` inside a name (`informe..final.pdf`) are rejected.
    - [x] `deleteByPrefix` leaves rows behind for prefixes with characters outside the BMP (emoji).
    - [x] Dead code: the console's `S3SigV4Signer` (and its `crypto` dependency); the hex id
      generator copied in `ObjectService` and `MultipartService`.

## After 1.0 (future improvements)

- [ ] Redesign the login screen to feature the dot grid in the background and incorporate the visual
  identity (Logo, phrases, tags...).
- [x] Upgrade to Winter `1.0.0-rc.3`: its complete Problem Details (RFC 9457, with `instance`),
  `TrustedProxies`, the `RateLimit` headers, `application/health+json` and conditional `GET`s
  (`304`/`412`); what is left out on purpose is in `DECISIONS.md` §12.
- [ ] Upload the social preview of `docs/design/brand/images/` to the GitHub repository (GitHub
  only offers it once the repository is public).
- [ ] A promo video with real screenshots of the design.
- [ ] Rename and move folders (all their content has to be copied and deleted, and it must be
  decided what happens if it fails halfway).
- [ ] Move object search and filters to the service, to search the whole folder and not only the
  pages already loaded.
- Performance (`service/tool/benchmark/RESULTS.md`, *What would improve it*):
    - [ ] ListBuckets from the `object_meta` table (a `SUM`/`COUNT` by bucket) instead of walking
      every object of the storage: ~1 s with 16 000 objects, ~6 s with 100 000.
    - [ ] Reads of small objects: 2047 GETs/s of 1 KiB against MinIO's 7629. Each GET looks up the
      metadata in SQLite and checks the file's size and date; a memory cache of the metadata of the
      hot objects would cut that fixed cost.
    - [ ] Profile big single uploads: a PUT of 16 MiB stays at ~147 MiB/s against MinIO's 477, while
      multipart gets about as much with 2 uploads (the md5 in Dart over every chunk, the size of the
      chunks written).
    - [ ] An index of keys (from `object_meta`) for listings, constant per page whatever the size of
      the folder: what would take it to hundreds of thousands of objects.
- [ ] A higher general rate limit (or none) for signed requests: one machine with many parallel
  workers gets `SlowDown` above 2000 requests/min (`service/tool/benchmark/RESULTS.md`).

## Parked

- Console light theme.
- Bucket policies, MD5/checksum validation and advanced multipart cases.
- S3 compatibility that is out of scope (it shows up in Mint): SigV2 signatures (including
  `s3 presign` from CLI v1), validating `x-amz-content-sha256` and the `aws-chunked` checksums,
  POST policy uploads, versioning and tags (only answered as none), notifications, S3 Select,
  retention/object lock and MinIO's own APIs (admin, snowball, force-delete).
- Keys with characters the filesystem doesn't support (`<>:"|?*` on Windows): keys would have to be
  encoded on disk.

## Ideas

- A WebSocket so the console learns when a file has been uploaded and refreshes by itself.
- An endpoint that returns the whole tree of files of a bucket as JSON.
- Backups started by hand (from the console or the admin API).
