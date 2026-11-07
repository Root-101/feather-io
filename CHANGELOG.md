# Changelog

What changed in each version of Feather IO, in broad strokes. The service and the console are
released together with the same version; the details of each are in their own changelogs:
[`service/CHANGELOG.md`](service/CHANGELOG.md) and [`console/CHANGELOG.md`](console/CHANGELOG.md).

## 1.1.1 (2026-11-06)

- Console: the success notices of renaming, moving, creating a bucket, an anonymous rule or an
  access key show again (they failed in the published build).

## 1.1.0 (2026-11-06)

- Service: listens on IPv4 and IPv6 (`::`) by default, so it can be reached over private networks
  that are IPv6 only, such as Railway's; `HOST` changes it.
- Console: shows the browser's language (Spanish or English) until the user picks one, the splash
  included.
- Both images are published on each release, for amd64 and arm64:
  `ghcr.io/root-101/feather-io` and `ghcr.io/root-101/feather-io-console`. `docker-compose.yml`
  uses them, so it no longer builds anything.

## 1.0.2 (2026-10-31)

- This changelog: the general changes of each version, with the details in the changelogs of
  the service and the console.

## 1.0.1 (2026-10-31)

- Service: two uploads of the same key at once could leave the content of one with the headers of
  the other.

## 1.0.0 (2026-10-31)

The first stable version, after seven release candidates, on Winter `1.0.0`.

- Service: the S3 API within its scope, SigV4 and JWT, access keys per bucket, anonymous rules,
  rate limits, the admin API with OpenAPI and a 24 MB Docker image. AWS CLI, rclone and MinIO Mint
  pass without failures in scope.
- Console: object tables behave like links (hand cursor, the name underlined, a click opens an
  object's details), a right click opens the menu of a bucket or object, and text is no longer
  selectable.

## 1.0.0-rc.7 (2026-10-25)

- Service: Winter `1.0.0-rc.6`, with a readable route table in the start-up log.
- Console: new login screen, the splash of `index.html`, and texts as slang YAML files like the
  service's.

## 1.0.0-rc.6 (2026-10-22)

Fixes from a security audit and a code audit.

- Service: unsigned `x-amz-*` headers are rejected, the admin API only reads JSON bodies sent as
  JSON, HTML/SVG/XML objects are sandboxed, tighter anonymous rules and login lock, `409 KeyConflict`
  for a key and a folder with the same name, safer parallel uploads and multipart completes, and a
  daily cleanup of temp files and stale multipart uploads.
- Console: previews never run uploaded pages, nginx sends a Content-Security-Policy and other
  security headers, and keys with `#` or `%` are encoded in the URLs.
- Both: `pubspec.lock` is committed and the Docker images resolve with `--enforce-lockfile`.

## 1.0.0-rc.5 (2026-10-19)

- Service: Winter `1.0.0-rc.3`, the IETF `RateLimit` headers, a health check in
  `application/health+json` (update probes that read its body), conditional GETs (`304`/`412`),
  and `X-Forwarded-Proto` from trusted proxies.

## 1.0.0-rc.4 (2026-10-15)

- Console: the details of an SVG object show its preview.

## 1.0.0-rc.3 (2026-10-13)

- Console: uploads send the `Content-Type` of the file's extension instead of `application/json`.

## 1.0.0-rc.2 (2026-10-11)

- Service: the Docker image no longer declares a `VOLUME` (Railway rejects it).
- Console: `GET /health` in nginx for the orchestrator.

## 1.0.0-rc.1 (2026-10-10)

First release candidate.

- Service: the S3-compatible API (buckets, objects, folders, ListObjects V1/V2, multipart,
  presigned URLs), SigV4 and JWT, access keys, anonymous rules, the admin API, health check,
  structured logs and a Docker image.
- Console: the object browser with a background transfer queue, the *Buckets* and *Access keys*
  sections, English and Spanish, and a Docker image on nginx.
