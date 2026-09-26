import 'dart:io';

import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:lux/lux_core.dart';

import 'release_utils.dart';

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
    fail('Unknown argument(s): ${unknown.join(', ')}. Use --ios and/or --android.');
  }

  final deployIos = args.has('--ios') || !args.has('--android');
  final deployAndroid = args.has('--android') || !args.has('--ios');

  final env = loadReleaseEnv();

  if (deployAndroid) {
    printSection('Android');
    await _deployAndroid(env);
  }

  if (deployIos) {
    printSection('iOS');
    await _deployIos(env);
  }

  printSection('Done');
  stdout.writeln('Deployment finished successfully.');
}

// ---------------------------------------------------------------------------
// Android -> Google Play internal testing
// ---------------------------------------------------------------------------

Future<void> _deployAndroid(Map<String, String> env) async {
  final packageName = env.require('ANDROID_PACKAGE_NAME');
  final serviceAccountFile = _resolve(env.require('PLAY_SERVICE_ACCOUNT_JSON'));
  if (!serviceAccountFile.existsSync()) {
    fail('Play service account JSON not found at ${serviceAccountFile.path}');
  }

  runCommand('flutter', ['build', 'appbundle', '--release']);

  final aab = File('build/app/outputs/bundle/release/app-release.aab');
  if (!aab.existsSync()) {
    fail('Expected app bundle not found at ${aab.path}');
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
    fail('App Store Connect API key not found at ${apiKey.path}');
  }

  // altool looks for AuthKey_<keyId>.p8 in ~/.appstoreconnect/private_keys.
  final home = Platform.environment['HOME']!;
  final keyDir = Directory('$home/.appstoreconnect/private_keys')..createSync(recursive: true);
  final destKey = File('${keyDir.path}/AuthKey_$keyId.p8');
  destKey.writeAsBytesSync(apiKey.readAsBytesSync());

  runCommand(
    'flutter',
    ['build', 'ipa', '--release', '--export-method', 'app-store'],
    environment: {...Platform.environment, 'FIREBASE_ANALYTICS_WITHOUT_ADID': 'true'},
  );

  final ipaDir = Directory('build/ios/ipa');
  final ipa = ipaDir.existsSync()
      ? ipaDir.listSync().whereType<File>().firstWhere(
          (f) => f.path.endsWith('.ipa'),
          orElse: () => fail('No .ipa found in ${ipaDir.path}'),
        )
      : fail('Expected IPA directory not found at ${ipaDir.path}');

  stdout.writeln('Uploading ${ipa.path} (${_mb(ipa.lengthSync())}) to TestFlight...');
  runCommand('xcrun', [
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

/// Resolves a path from .env relative to the project root.
File _resolve(String path) => File(path);

String _mb(int bytes) => '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
