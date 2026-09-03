import 'dart:io';

import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:lux/lux_core.dart';

/// Builds release artifacts and deploys them to the stores.
///
/// Usage:
///   dart run tool/release/deploy.dart            # both platforms
///   dart run tool/release/deploy.dart --ios      # iOS only -> TestFlight
///   dart run tool/release/deploy.dart --android  # Android only -> Play internal
///
/// Configuration lives in tool/release/.env (see tool/release/.env.example).
Future<void> main(List<String> args) async {
  final unknown = args.where((a) => a != '--ios' && a != '--android').toList();
  if (unknown.isNotEmpty) {
    _fail('Unknown argument(s): ${unknown.join(', ')}. Use --ios and/or --android.');
  }

  final deployIos = args.has('--ios') || !args.has('--android');
  final deployAndroid = args.has('--android') || !args.has('--ios');

  final env = _loadEnv();

  if (deployAndroid) {
    _section('Android');
    await _deployAndroid(env);
  }

  if (deployIos) {
    _section('iOS');
    await _deployIos(env);
  }

  _section('Done');
  stdout.writeln('Deployment finished successfully.');
}

// ---------------------------------------------------------------------------
// Android -> Google Play internal testing
// ---------------------------------------------------------------------------

Future<void> _deployAndroid(Map<String, String> env) async {
  final packageName = env.require('ANDROID_PACKAGE_NAME');
  final serviceAccountFile = _resolve(env.require('PLAY_SERVICE_ACCOUNT_JSON'));
  if (!serviceAccountFile.existsSync()) {
    _fail('Play service account JSON not found at ${serviceAccountFile.path}');
  }

  _run('flutter', ['build', 'appbundle', '--release']);

  final aab = File('build/app/outputs/bundle/release/app-release.aab');
  if (!aab.existsSync()) {
    _fail('Expected app bundle not found at ${aab.path}');
  }

  stdout.writeln('Authenticating with Google Play...');
  final credentials = ServiceAccountCredentials.fromJson(serviceAccountFile.readAsStringSync());
  final client = await clientViaServiceAccount(credentials, [AndroidPublisherApi.androidpublisherScope]);

  try {
    final publisher = AndroidPublisherApi(client);

    stdout.writeln('Creating edit...');
    final edit = await publisher.edits.insert(AppEdit(), packageName);
    final editId = edit.id!;

    stdout.writeln('Uploading ${aab.path} (${_mb(aab.lengthSync())})...');
    final upload = await publisher.edits.bundles.upload(
      packageName,
      editId,
      uploadMedia: Media(aab.openRead(), aab.lengthSync(), contentType: 'application/octet-stream'),
    );
    final versionCode = upload.versionCode!;
    stdout.writeln('Uploaded version code $versionCode.');

    stdout.writeln('Assigning to "internal" track...');
    await publisher.edits.tracks.update(
      Track(
        track: 'internal',
        releases: [
          TrackRelease(status: 'completed', versionCodes: [versionCode.toString()]),
        ],
      ),
      packageName,
      editId,
      'internal',
    );

    stdout.writeln('Committing edit...');
    await publisher.edits.commit(packageName, editId);
    stdout.writeln('Android version code $versionCode is live on the internal track.');
  } finally {
    client.close();
  }
}

// ---------------------------------------------------------------------------
// iOS -> TestFlight
// ---------------------------------------------------------------------------

Future<void> _deployIos(Map<String, String> env) async {
  final keyId = env.require('ASC_KEY_ID');
  final issuerId = env.require('ASC_ISSUER_ID');
  final apiKey = _resolve(env.require('ASC_API_KEY_PATH'));
  if (!apiKey.existsSync()) {
    _fail('App Store Connect API key not found at ${apiKey.path}');
  }

  // altool looks for AuthKey_<keyId>.p8 in ~/.appstoreconnect/private_keys.
  final home = Platform.environment['HOME']!;
  final keyDir = Directory('$home/.appstoreconnect/private_keys')..createSync(recursive: true);
  final destKey = File('${keyDir.path}/AuthKey_$keyId.p8');
  destKey.writeAsBytesSync(apiKey.readAsBytesSync());

  _run(
    'flutter',
    ['build', 'ipa', '--release', '--export-method', 'app-store'],
    environment: {...Platform.environment, 'FIREBASE_ANALYTICS_WITHOUT_ADID': 'true'},
  );

  final ipaDir = Directory('build/ios/ipa');
  final ipa = ipaDir.existsSync()
      ? ipaDir.listSync().whereType<File>().firstWhere(
          (f) => f.path.endsWith('.ipa'),
          orElse: () => _fail('No .ipa found in ${ipaDir.path}'),
        )
      : _fail('Expected IPA directory not found at ${ipaDir.path}');

  stdout.writeln('Uploading ${ipa.path} (${_mb(ipa.lengthSync())}) to TestFlight...');
  _run('xcrun', [
    'altool',
    '--upload-app',
    '--type',
    'ios',
    '--file',
    ipa.path,
    '--apiKey',
    keyId,
    '--apiIssuer',
    issuerId,
  ]);
  stdout.writeln('iOS build uploaded. It will appear in TestFlight after Apple finishes processing.');
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Map<String, String> _loadEnv() {
  final file = File('tool/release/.env');
  if (!file.existsSync()) {
    _fail('Missing tool/release/.env. Copy tool/release/.env.example and fill it in.');
  }
  final env = <String, String>{};
  for (final raw in file.readAsLinesSync()) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final eq = line.indexOf('=');
    if (eq == -1) continue;
    final key = line.substring(0, eq).trim();
    var value = line.substring(eq + 1).trim();
    if (value.length >= 2 &&
        ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'")))) {
      value = value.substring(1, value.length - 1);
    }
    env[key] = value;
  }
  return env;
}

/// Resolves a path from .env relative to the project root.
File _resolve(String path) => File(path);

void _run(String executable, List<String> args, {Map<String, String>? environment}) {
  stdout.writeln('\$ $executable ${args.join(' ')}');
  final result = Process.runSync(executable, args, runInShell: true, environment: environment);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  if (result.exitCode != 0) {
    _fail('$executable exited with code ${result.exitCode}.');
  }
}

void _section(String title) => stdout.writeln('\n=== $title ===');

String _mb(int bytes) => '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';

Never _fail(String message) {
  stderr.writeln('Error: $message');
  exit(1);
}

extension on Map<String, String> {
  String require(String key) {
    final value = this[key];
    if (value == null || value.isEmpty) {
      _fail('Missing required value "$key" in tool/release/.env');
    }
    return value;
  }
}
