@TestOn('vm')
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:service/feather.dart';
import 'package:test/test.dart';

import '../../../support/test_server.dart';

void main() {
  final server = TestServer(port: 8086, name: 'put_test');
  const bucket = 'put-bucket';

  setUpAll(() async {
    await server.start();
    await server.createBucket(bucket);
  });
  tearDownAll(server.stop);

  group('S3Controller - PUT Object', () {
    test('Should upload successfully in root', () async {
      final response = await http.put(
        server.url('/$bucket/file.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 200);
      expect(
        await File('${server.storagePath}/$bucket/file.txt').readAsString(),
        'data',
      );
    });

    test('Should upload successfully in deep folders', () async {
      final response = await http.put(
        server.url('/$bucket/a/b/c/d/file.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 200);
      expect(
        await File('${server.storagePath}/$bucket/a/b/c/d/file.txt').exists(),
        isTrue,
      );
    });

    test('Should answer the ETag (md5 of the content) without body', () async {
      final response = await http.put(
        server.url('/$bucket/etag.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 200);
      expect(response.headers['etag'], '"${md5.convert(utf8.encode('data'))}"');
      expect(response.body, isEmpty);
    });

    test('Should not create the bucket if it does not exist (404)', () async {
      final response = await http.put(
        server.url('/missing/file.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 404);
      expect(response.body, contains('<Code>NoSuchBucket</Code>'));
      expect(
        await Directory('${server.storagePath}/missing').exists(),
        isFalse,
      );
    });

    test('Should fail without auth (401)', () async {
      final response = await http.put(
        server.url('/$bucket/nopass.txt'),
        body: 'data',
      );
      expect(response.statusCode, 401);
    });

    test('Should fail with an invalid token (401)', () async {
      final response = await http.put(
        server.url('/$bucket/wrong.txt'),
        headers: {'authorization': 'Bearer not-a-jwt'},
        body: 'data',
      );
      expect(response.statusCode, 401);
    });

    test('Should fail with invalid bucket name (400)', () async {
      final response = await http.put(
        server.url('/INVALID_BUCKET/file.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 400);
      expect(response.body, contains('<Code>InvalidBucketName</Code>'));
    });

    test('Should fail with path traversal in key (400)', () async {
      // With %2F the client doesn't normalize the '..' and the key reaches the server as is
      final response = await http.put(
        server.url('/$bucket/..%2F..%2Fescape.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 400);
      expect(await File('${server.storagePath}/escape.txt').exists(), isFalse);
      expect(await File('./uploads_test/escape.txt').exists(), isFalse);
    });

    test('Should upload a key with ".." inside a name', () async {
      final response = await http.put(
        server.url('/$bucket/informe..final.pdf'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 200, reason: response.body);
      expect(
        await File('${server.storagePath}/$bucket/informe..final.pdf').readAsString(),
        'data',
      );
    });

    test('Should not let a key with an empty segment overwrite another (400)', () async {
      await server.putObject(bucket, 'alias/file.txt', 'original');
      final response = await http.put(
        server.url('/$bucket/alias//file.txt'),
        headers: server.auth(),
        body: 'replaced',
      );
      expect(response.statusCode, 400);
      expect(response.body, contains('<Code>InvalidArgument</Code>'));
      expect(
        await File('${server.storagePath}/$bucket/alias/file.txt').readAsString(),
        'original',
      );
    });

    test('Should fail with invalid characters in key (400)', () async {
      final response = await http.put(
        server.url('/$bucket/invalid:file.txt'),
        headers: server.auth(),
        body: 'data',
      );
      expect(response.statusCode, 400);
      expect(response.body, contains('<Code>InvalidArgument</Code>'));
    });
  });

  group('S3Controller - PUT Object over an open file (Windows)', () {
    // On Windows an open file can't be replaced: it is retried for a while
    // and, if it stays open, 503 (S3 clients retry it)
    Future<RandomAccessFile> openFor(String key, Duration duration) async {
      final handle = await File('${server.storagePath}/$bucket/$key').open();
      unawaited(Future<void>.delayed(duration, handle.close));
      return handle;
    }

    test('Should replace an object that is open for a moment', () async {
      await server.putObject(bucket, 'open.txt', 'before');
      await openFor('open.txt', const Duration(milliseconds: 300));

      final response = await http.put(
        server.url('/$bucket/open.txt'),
        headers: server.auth(),
        body: 'after',
      );
      expect(response.statusCode, 200, reason: response.body);
      expect(
        await File('${server.storagePath}/$bucket/open.txt').readAsString(),
        'after',
      );
    }, testOn: 'windows');

    test('Should copy onto an object that is open for a moment', () async {
      await server.putObject(bucket, 'copy-source.txt', 'new');
      await server.putObject(bucket, 'copy-open.txt', 'old');
      await openFor('copy-open.txt', const Duration(milliseconds: 300));

      final response = await http.put(
        server.url('/$bucket/copy-open.txt'),
        headers: {
          ...server.auth(),
          'x-amz-copy-source': '/$bucket/copy-source.txt',
        },
      );
      expect(response.statusCode, 200, reason: response.body);
      expect(
        await File('${server.storagePath}/$bucket/copy-open.txt')
            .readAsString(),
        'new',
      );
    }, testOn: 'windows');

    test(
      'Should answer 503 and keep the object if it stays open',
      () async {
        await server.putObject(bucket, 'locked.txt', 'before');
        final handle = await openFor(
          'locked.txt',
          ObjectService.replaceTimeout + const Duration(seconds: 3),
        );

        final response = await http.put(
          server.url('/$bucket/locked.txt'),
          headers: server.auth(),
          body: 'after',
        );
        await handle.close();
        expect(response.statusCode, 503);
        expect(response.body, contains('<Code>ServiceUnavailable</Code>'));
        expect(
          await File('${server.storagePath}/$bucket/locked.txt').readAsString(),
          'before',
        );
        // and the temp file is gone
        expect(
          await Directory('${server.storagePath}/.tmp').list().isEmpty,
          isTrue,
        );
      },
      testOn: 'windows',
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });

  group('S3Controller - PUT Object key validation', () {
    test('Should reject a backslash in the key (400)', () async {
      // On Windows `a\b` would be another way to write `a/b`, and it would let
      // a client write the folder marker (`x\.feather-folder`)
      for (final key in ['folder%5Cfile.txt', 'other%5C.feather-folder']) {
        final response = await http.put(
          server.url('/$bucket/$key'),
          headers: server.auth(),
          body: 'x',
        );
        expect(response.statusCode, 400, reason: key);
        expect(response.body, contains('<Code>InvalidArgument</Code>'));
      }
      expect(
        await File('${server.storagePath}/$bucket/folder/file.txt').exists(),
        isFalse,
      );
    });
  });

  group('S3Controller - PUT Object over a folder or under an object (409)', () {
    List<FileSystemEntity> temps() {
      final dir = Directory('${server.storagePath}/${ObjectService.tempFolderName}');
      return dir.existsSync() ? dir.listSync() : [];
    }

    Future<http.Response> put(String key, {Map<String, String> headers = const {}}) =>
        http.put(
          server.url('/$bucket/$key'),
          headers: {...server.auth(), ...headers},
          body: 'data',
        );

    test('Should not create a key under an object', () async {
      await server.putObject(bucket, 'conflict/docs', 'a file');
      final response = await put('conflict/docs/readme.txt');
      expect(response.statusCode, 409, reason: response.body);
      expect(response.body, contains('<Code>KeyConflict</Code>'));
      expect(response.body, contains('conflict/docs'));
      expect(temps(), isEmpty);

      final folder = await put('conflict/docs/sub/');
      expect(folder.statusCode, 409, reason: folder.body);
      expect(
        await File('${server.storagePath}/$bucket/conflict/docs').readAsString(),
        'a file',
      );
    });

    test('Should not replace a folder that holds objects with an object', () async {
      await server.putObject(bucket, 'conflict/pics/a.jpg', 'jpg');
      final response = await put('conflict/pics');
      expect(response.statusCode, 409, reason: response.body);
      expect(response.body, contains('<Code>KeyConflict</Code>'));
      expect(temps(), isEmpty);
      expect(
        await File('${server.storagePath}/$bucket/conflict/pics/a.jpg').readAsString(),
        'jpg',
      );
    });

    test('Should not copy onto a folder (409)', () async {
      await server.putObject(bucket, 'conflict/source.txt', 'source');
      final response = await put(
        'conflict/pics',
        headers: {'x-amz-copy-source': '/$bucket/conflict/source.txt'},
      );
      expect(response.statusCode, 409, reason: response.body);
      expect(temps(), isEmpty);
    });
  });
}
