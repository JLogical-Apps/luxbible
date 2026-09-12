import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:uuid/uuid.dart';
import 'environment.dart';

String getSafeMessage(Object? value) {
  var text = '${getRedactedValue(value)}';
  for (final secret in getSecrets()) {
    text = text.replaceAll(secret, '[redacted]');
  }
  return text
      .replaceAll(
        RegExp(r'https?://[^\s"<>]+\?[^\s"<>]+'),
        '[URL with query redacted]',
      )
      .replaceAll(
        RegExp(r'Bearer\s+\S+', caseSensitive: false),
        'Bearer [redacted]',
      );
}

Object? getRedactedValue(Object? value) => switch (value) {
  Map() => Map.fromEntries(
    value.entries.map(
      (entry) => MapEntry(
        entry.key,
        RegExp(
              r'token|secret|authorization|api.?key|password|uploadurl|authurl',
              caseSensitive: false,
            ).hasMatch('${entry.key}')
            ? '[redacted]'
            : getRedactedValue(entry.value),
      ),
    ),
  ),
  List() => value.map(getRedactedValue).toList(),
  _ => value,
};

class ApiFailure implements Exception {
  final int? status;
  final dynamic data;
  final String operation;
  ApiFailure(this.operation, this.status, this.data);
  bool get isAmbiguous => status == null || status! >= 500 || status == 408;
  @override
  String toString() => getSafeMessage(
    '$operation: ${status == null ? 'network timeout or connection failure' : 'HTTP $status'} ${data is Map ? jsonEncode(getRedactedValue({
            for (final key in ['code', 'message', 'error', 'validationErrors', 'details'])
              if (data.containsKey(key)) key: data[key],
          })) : ''}',
  );
}

class Api {
  final Uri base;
  final String key;
  final http.Client client;
  void Function(int)? onUpload;
  Api(String base, this.key, {http.Client? client})
    : base = Uri.parse(base),
      client =
          client ??
          IOClient(HttpClient()..connectionTimeout = Duration(seconds: 30));

  Future<dynamic> call(
    String method,
    String path, {
    Object? body,
    Map<String, String> headers = const {},
  }) async {
    final abort = Completer<void>();
    final request =
        http.AbortableRequest(
            method,
            base.resolve('${base.path}/$path'),
            abortTrigger: abort.future,
          )
          ..followRedirects = false
          ..headers.addAll({...headers, 'Authorization': 'Bearer $key'});
    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }
    try {
      return await (() async {
        final response = await http.Response.fromStream(
          await client.send(request),
        );
        dynamic data;
        try {
          data = response.body.isEmpty
              ? <String, dynamic>{}
              : jsonDecode(response.body);
        } catch (_) {
          data = <String, dynamic>{};
        }
        if (response.statusCode < 200 || response.statusCode >= 300)
          throw ApiFailure('$method $path', response.statusCode, data);
        return data;
      })().timeout(Duration(minutes: 3));
    } on ApiFailure {
      rethrow;
    } catch (_) {
      throw ApiFailure('$method $path', null, null);
    } finally {
      abort.complete();
    }
  }

  Future<void> putFile(
    String url,
    File file, {
    int start = 0,
    int? end,
    String? mime,
  }) async {
    final uri = Uri.parse(url);
    if (uri.scheme != 'https')
      throw FormatException('Upload URL must use HTTPS');
    final abort = Completer<void>();
    final request = FileUploadRequest(
      uri,
      file,
      start,
      end ?? await file.length(),
      abort.future,
      onProgress: onUpload,
    )..followRedirects = false;
    if (mime != null) request.headers['Content-Type'] = mime;
    try {
      await (() async {
        final response = await client.send(request);
        await response.stream.drain<void>();
        if (response.statusCode < 200 || response.statusCode >= 300)
          throw ApiFailure('Media PUT', response.statusCode, null);
      })().timeout(Duration(minutes: 10));
    } on ApiFailure {
      rethrow;
    } catch (_) {
      throw ApiFailure('Media PUT', null, null);
    } finally {
      abort.complete();
    }
  }

  void close() => client.close();
}

class FileUploadRequest extends http.BaseRequest with http.Abortable {
  final File file;
  final int start;
  final void Function(int)? onProgress;
  @override
  final Future<void> abortTrigger;
  FileUploadRequest(
    Uri url,
    this.file,
    this.start,
    int end,
    this.abortTrigger, {
    this.onProgress,
  }) : super('PUT', url) {
    contentLength = end - start;
  }

  @override
  http.ByteStream finalize() {
    super.finalize();
    return http.ByteStream(
      file.openRead(start, start + contentLength!).map((chunk) {
        onProgress?.call(chunk.length);
        return chunk;
      }),
    );
  }
}

String getRequestId() => Uuid().v4();
