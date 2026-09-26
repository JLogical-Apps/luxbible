import 'dart:convert';
import 'dart:io';

import 'package:lux/lux_core.dart';

import 'release_utils.dart';

/// Pushes the App Store and Google Play listing text in the fastlane metadata folders, or pulls the
/// live listings over them with `--pull` so `git diff` shows what differs.
///
/// Usage:
///   dart run tool/release/listings.dart                  # push both listings
///   dart run tool/release/listings.dart --ios            # App Store only
///   dart run tool/release/listings.dart --android        # Google Play only
///   dart run tool/release/listings.dart --pull [--ios | --android]
///
/// Pushing never uploads builds or screenshots and never submits for review.
Future<void> main(List<String> args) async {
  final unknown = args.where((arg) => !['--ios', '--android', '--pull'].contains(arg)).toList();
  if (unknown.isNotEmpty) {
    fail('Unknown argument(s): ${unknown.join(', ')}. Use --pull, --ios, and/or --android.');
  }

  final isPull = args.has('--pull');
  final includesIos = args.has('--ios') || !args.has('--android');
  final includesAndroid = args.has('--android') || !args.has('--ios');

  final env = loadReleaseEnv();
  final (:marketingVersion, :buildNumber) = readPubspecVersion();

  if (includesAndroid) {
    printSection('Google Play');
    isPull ? await pullAndroid(env) : await pushAndroid(env, buildNumber: buildNumber);
  }

  if (includesIos) {
    printSection('App Store');
    isPull ? await pullIos(env) : await pushIos(env, marketingVersion: marketingVersion);
  }

  printSection('Done');
  stdout.writeln(isPull ? 'Live listings pulled. Review them with `git diff`.' : 'Listings pushed.');
}

const iosBundleId = 'app.luxbible.app';
const iosMetadataPath = 'ios/fastlane/metadata';
const androidMetadataPath = 'android/fastlane/metadata/android';

// Builds from `deploy` land on the internal track, and promoting a release keeps its notes.
const playReleaseNotesTrack = 'internal';

({String marketingVersion, String buildNumber}) readPubspecVersion() {
  final match = RegExp(
    r'^version:\s*(\S+)\+(\d+)',
    multiLine: true,
  ).firstMatch(File('pubspec.yaml').readAsStringSync());
  if (match == null) fail('Could not read a version like 1.2.3+45 from pubspec.yaml');
  return (marketingVersion: match.group(1)!, buildNumber: match.group(2)!);
}

Future<void> pushIos(Map<String, String> env, {required String marketingVersion}) =>
    withAppStoreConnectKey(env, (keyPath) async {
      stdout.writeln('fastlane shows a preview of the $marketingVersion listing and asks before uploading.');
      await runFastlane([
        'deliver',
        ...appStoreConnectArgs(keyPath),
        '--app_version',
        marketingVersion,
        '--metadata_path',
        iosMetadataPath,
        '--skip_binary_upload',
        'true',
        '--skip_screenshots',
        'true',
        '--submit_for_review',
        'false',
      ]);
    });

Future<void> pullIos(Map<String, String> env) {
  requireCommitted(iosMetadataPath);
  return withAppStoreConnectKey(
    env,
    (keyPath) => withTemporaryDirectory((directory) async {
      final downloadPath = '$directory/metadata';
      await runFastlane([
        'deliver',
        'download_metadata',
        ...appStoreConnectArgs(keyPath),
        '--metadata_path',
        downloadPath,
        '--use_live_version',
        'true',
        '--force',
        'true',
      ]);
      copyTrackedFiles(from: downloadPath, to: iosMetadataPath);
    }),
  );
}

Future<void> pushAndroid(Map<String, String> env, {required String buildNumber}) async {
  final languages = Directory(
    androidMetadataPath,
  ).listSync().whereType<Directory>().map((dir) => dir.path.split('/').last);
  stdout.write(
    'Push the Google Play listing for ${languages.join(', ')} and the build $buildNumber release notes on the '
    '$playReleaseNotesTrack track? This goes live immediately. [y/N] ',
  );
  if (stdin.readLineSync()?.trim().toLowerCase() != 'y') fail('Canceled.');

  await runFastlane([
    'supply',
    ...playArgs(env),
    '--metadata_path',
    androidMetadataPath,
    '--track',
    playReleaseNotesTrack,
    '--version_code',
    buildNumber,
    '--skip_upload_apk',
    'true',
    '--skip_upload_aab',
    'true',
    '--skip_upload_images',
    'true',
    '--skip_upload_screenshots',
    'true',
  ]);
}

Future<void> pullAndroid(Map<String, String> env) {
  requireCommitted(androidMetadataPath);
  return withTemporaryDirectory((directory) async {
    final downloadPath = '$directory/metadata';
    await runFastlane(['supply', 'init', ...playArgs(env), '--metadata_path', downloadPath]);
    copyTrackedFiles(from: downloadPath, to: androidMetadataPath);
  });
}

List<String> appStoreConnectArgs(String keyPath) => [
  '--api_key_path',
  keyPath,
  '--app_identifier',
  iosBundleId,
  '--platform',
  'ios',
];

List<String> playArgs(Map<String, String> env) {
  final serviceAccount = File(env.require('PLAY_SERVICE_ACCOUNT_JSON'));
  if (!serviceAccount.existsSync()) fail('Play service account JSON not found at ${serviceAccount.path}');
  return ['--json_key', serviceAccount.path, '--package_name', env.require('ANDROID_PACKAGE_NAME')];
}

// fastlane's CLI only accepts an App Store Connect key as a JSON file holding the key itself.
Future<void> withAppStoreConnectKey(Map<String, String> env, Future<void> Function(String keyPath) action) {
  final key = File(env.require('ASC_API_KEY_PATH'));
  if (!key.existsSync()) fail('App Store Connect API key not found at ${key.path}');

  return withTemporaryDirectory((directory) {
    final keyFile = File('$directory/api_key.json')
      ..writeAsStringSync(
        jsonEncode({
          'key_id': env.require('ASC_KEY_ID'),
          'issuer_id': env.require('ASC_ISSUER_ID'),
          'key': key.readAsStringSync(),
          'in_house': false,
        }),
      );
    return action(keyFile.path);
  });
}

Future<void> withTemporaryDirectory(Future<void> Function(String path) action) async {
  final directory = Directory.systemTemp.createTempSync('lux-listings-');
  try {
    await action(directory.path);
  } finally {
    directory.deleteSync(recursive: true);
  }
}

// A pull overwrites the local files, so they must be recoverable from git.
void requireCommitted(String path) {
  final status = Process.runSync('git', ['status', '--porcelain', '--', path]).stdout.toString().trim();
  if (status.isNotEmpty) {
    fail('$path has uncommitted changes. Commit or stash them before pulling the live listing.');
  }
}

// Only fields already kept in the repo are overwritten, so a pull never brings in images or the
// review contact details App Store Connect returns.
void copyTrackedFiles({required String from, required String to}) {
  final updates = Directory(to)
      .listSync(recursive: true)
      .whereType<File>()
      .map((local) => (local: local, live: File('$from${local.path.substring(to.length)}')))
      .where((pair) => pair.live.existsSync())
      .map((pair) => (local: pair.local, text: '${pair.live.readAsStringSync().trim()}\n'))
      .where((update) => update.local.readAsStringSync() != update.text)
      .toList();

  for (final update in updates) {
    update.local.writeAsStringSync(update.text);
  }

  stdout.writeln(
    updates.isEmpty
        ? 'The live listing matches the local files.'
        : 'Updated from the live listing:\n${updates.map((update) => '  ${update.local.path}').join('\n')}',
  );
}

Future<void> runFastlane(List<String> args) async {
  stdout.writeln('\$ fastlane ${args.join(' ')}');
  final process = await Process.start(
    'fastlane',
    args,
    mode: ProcessStartMode.inheritStdio,
    environment: {
      'LC_ALL': 'en_US.UTF-8',
      'LANG': 'en_US.UTF-8',
      'FASTLANE_SKIP_UPDATE_CHECK': '1',
      'FASTLANE_HIDE_CHANGELOG': '1',
      'FASTLANE_OPT_OUT_USAGE': '1',
    },
  );
  final exitCode = await process.exitCode;
  if (exitCode != 0) fail('fastlane exited with code $exitCode.');
}
