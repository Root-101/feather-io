# Changelog

## 1.0.0-rc.7 (2026-10-25)

- New login: the brand next to the form over the dot grid (stacked in narrow windows), a hint with
  the variables that hold the keys, the language selector and a credit to Root101.
- The splash is the same as the one of `index.html`.
- The texts are slang YAML files grouped by feature (`lib/l10n/*.i18n.yaml`), like the service's,
  instead of `gen-l10n` ARB files; a text missing in Spanish no longer compiles.

## 1.0.0-rc.6 (2026-10-22)

- The preview opens images, video, audio and PDF as they are, and text, HTML, SVG and other markup
  as plain text: an uploaded page opened as a `blob:` of the console could run script next to the
  session. Anything else is downloaded.
- nginx sends a Content-Security-Policy (only the build's scripts), `X-Content-Type-Options`,
  `X-Frame-Options` and `Referrer-Policy`. The inline scripts of `index.html` moved to
  `splash.js`, and the build serves CanvasKit itself instead of Google's CDN.
- Object keys are encoded in the URLs: a `#` or `%` in a name pointed to another object.
- Opening a big folder and then a small one no longer shows the big one under the small one's URL.
- The help of the anonymous rule form says that a pattern only opens listings if it ends in `*`.
- Removed the unused SigV4 signer; `pubspec.lock` is committed.

## 1.0.0-rc.5 (2026-10-19)

- No changes; released with the service's upgrade to Winter `1.0.0-rc.3`.

## 1.0.0-rc.4 (2026-10-15)

- The details of an SVG object show its preview. It was downloaded but drawn as a raster image,
  which can't decode SVG, so the box stayed empty (#1). An image that can't be decoded shows the
  object icon instead of a blank box.

## 1.0.0-rc.3 (2026-10-13)

- Uploads send the `Content-Type` of the file's extension (`application/octet-stream` when
  unknown). They sent the JSON default of the HTTP client, which the service stores as the
  object's, so previews, public links and presigned URLs showed images as text. Objects uploaded
  before keep `application/json` until they are uploaded again.

## 1.0.0-rc.2 (2026-10-11)

- `GET /health` in nginx, for the orchestrator and the image's `HEALTHCHECK`; it never asks the
  service.

## 1.0.0-rc.1 (2026-10-10)

First release candidate of the web console.

- **Browser**: buckets and folders in list or grid view, paging, search and filters by type, size
  and date, previews, details, create folders, rename and move, delete, share links (1 hour, 1 day
  or 7 days) and zip downloads. The bucket, folder and view live in the URL.
- **Transfers**: uploads (drag & drop, multipart over 16 MiB) and downloads in a background queue
  that keeps going across folders, buckets and sections, with progress, cancel and retry.
- **Buckets**: create, edit (description and color), details and statistics, anonymous access rules,
  empty and delete.
- **Access keys**: create keys per bucket or for every bucket with an expiry, enable and disable,
  regenerate the secret (shown once).
- Session kept across reloads, the browser's password manager at login, English and Spanish, and a
  Docker image on nginx configured from the container's environment.
- The Feather IO icon ([`docs/brand.md`](../docs/brand.md)) as favicon, web icons and on the
  splash.
