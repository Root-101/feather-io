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

From 1 to 10, as a lightweight self-hosted S3 storage (2026-10-25, `1.0.0-rc.6`):

| Area                  |  Score  | Why                                                                                                         |
|-----------------------|:-------:|-------------------------------------------------------------------------------------------------------------|
| S3 compatibility      |  **9**  | AWS CLI and rclone pass everything; Mint only fails on what is out of scope                                 |
| Security              | **8.5** | SigV4 hardened, encrypted keys, rate limits, internal audit fixed. Missing: its own TLS and an external one |
| Tests                 | **8.5** | ~500 service tests, ~130 console tests and real clients, all in CI except Mint                              |
| Architecture and code |  **8**  | Clear layers and features; `ObjectService` is still big                                                     |
| Performance           | **7.5** | Light on memory, fast uploads and listings; small reads, big uploads and ListBuckets lag behind MinIO       |
| Production readiness  |  **6**  | Small image, logs, health check, backups. Missing: metrics, long-running use; Winter is still an RC         |

Overall **8**; within its scope it can reach **8.5–9**.

## Done (up to 1.0.0-rc.6)

- **S3 API** complete for its scope (objects, folders, ListObjects V1/V2, multipart, presigned
  URLs, `aws-chunked`, `501` for the rest), verified with the AWS CLI, rclone and MinIO Mint.
- **Access**: SigV4 and JWT, access keys per bucket, anonymous rules, rate limits.
- **Admin API** with Problem Details in English and Spanish and OpenAPI; **console** with browser,
  transfer queue, *Buckets* and *Access keys* sections.
- **Operations**: metadata in SQLite (WAL), benchmarks, health check, structured logs, Docker
  images, `docker-compose.yml`, CI, a Railway template, Winter `1.0.0-rc.5`.
- **Release**: open source docs and license, visual identity and icon, the security and code audit
  of 2026-10-21 fixed.

## Next

- [x] Migrate the console's localization from `gen-l10n` (ARB) to slang with YAML files, like the
  service (`lib/i18n/*.i18n.yaml`).
- [x] Redesign the login screen to feature the dot grid in the background and incorporate the visual
  identity (Logo, phrases, tags...).
- [x] Upload the social preview of `docs/design/brand/images/` to the GitHub repository (GitHub
  only offers it once the repository is public).
- [ ] A promo video with real screenshots of the design.
- [ ] Rename and move folders (all their content has to be copied and deleted, and it must be
  decided what happens if it fails halfway).
- [ ] Move object search and filters to the service, to search the whole folder and not only the
  pages already loaded.
- Performance (`service/tool/benchmark/RESULTS.md`, *What would improve it*):
    - [ ] ListBuckets from the `object_meta` table (a `SUM`/`COUNT` by bucket) instead of walking
      every object of the storage: ~1 s with 16 000 objects, ~6 s with 100 000.
    - [ ] Reads of small objects: 2047 GETs/s of 1 KiB against MinIO's 7629. A memory cache of the
      metadata of the hot objects would cut the fixed cost of each GET.
    - [ ] Profile big single uploads: a PUT of 16 MiB stays at ~147 MiB/s against MinIO's 477.
    - [ ] An index of keys (from `object_meta`) for listings, constant per page whatever the size of
      the folder.
- [ ] A higher general rate limit (or none) for signed requests: one machine with many parallel
  workers gets `SlowDown` above 2000 requests/min.

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
