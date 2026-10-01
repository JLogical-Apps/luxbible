import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class StatsException implements Exception {
  final String message;

  StatsException(this.message);

  @override
  String toString() => message;
}

class GoogleApi {
  final String token;
  final client = http.Client();

  GoogleApi._(this.token);

  // gcloud handles the impersonated service account in the ADC file, which Dart's auth libraries don't.
  static Future<GoogleApi> connect() async {
    final result = await Process.run('gcloud', [
      'auth',
      'application-default',
      'print-access-token',
      '--scopes=https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform',
    ]);
    if (result.exitCode != 0) {
      throw StatsException('gcloud could not provide Application Default Credentials: ${result.stderr}'.trim());
    }
    return GoogleApi._((result.stdout as String).trim());
  }

  Future<Map<String, dynamic>> send(Uri uri, {Object? body}) async {
    final headers = {'Authorization': 'Bearer $token', if (body != null) 'Content-Type': 'application/json'};
    final response = body == null
        ? await client.get(uri, headers: headers)
        : await client.post(uri, headers: headers, body: jsonEncode(body));
    final json = jsonDecode(response.body);
    if (response.statusCode >= 300) {
      throw StatsException(
        '${uri.host} returned ${response.statusCode}: ${json['error']?['message'] ?? response.body}',
      );
    }
    return json;
  }

  void close() => client.close();
}
