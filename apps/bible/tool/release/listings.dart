import 'dart:convert';
import 'dart:io';

import 'package:lux/lux_core.dart';

import 'release_utils.dart';

/// Pushes the App Store and Google Play listing text in the fastlane metadata folders, or pulls the
/// live listings over them with `--pull` so `git diff` shows what differs. `--screenshots` does the
/// same for the screenshots instead of the text.
///
/// Usage:
///   dart run tool/release/listings.dart                  # push both listings
///   dart run tool/release/listings.dart --ios            # App Store only
///   dart run tool/release/listings.dart --android        # Google Play only
///   dart run tool/release/listings.dart --pull [--ios | --android]
///   dart run tool/release/listings.dart --screenshots [--pull] [--ios | --android]
///
/// Pushing never uploads builds and never submits for review.
Future<void> main(List<String> args) async {
  final unknown = args.where((arg) => !['--ios', '--android', '--pull', '--screenshots'].contains(arg)).toList();
  if (unknown.isNotEmpty) {
    fail('Unknown argument(s): ${unknown.join(', ')}. Use --pull, --screenshots, --ios, and/or --android.');
  }

  final isPull = args.has('--pull');
  final isScreenshots = args.has('--screenshots');
  final includesIos = args.has('--ios') || !args.has('--android');
  final includesAndroid = args.has('--android') || !args.has('--ios');

  final env = loadReleaseEnv();
  final (:marketingVersion, :buildNumber) = readPubspecVersion();

  if (includesAndroid) {
    printSection(isScreenshots ? 'Google Play screenshots' : 'Google Play');
    await switch ((isPull, isScreenshots)) {
      (false, false) => pushAndroid(env, buildNumber: buildNumber),
      (true, false) => pullAndroid(env),
      (false, true) => pushAndroidScreenshots(env, buildNumber: buildNumber),
      (true, true) => pullAndroidScreenshots(env),
    };
  }

  if (includesIos) {
    printSection(isScreenshots ? 'App Store screenshots' : 'App Store');
    await switch ((isPull, isScreenshots)) {
      (false, false) => pushIos(env, marketingVersion: marketingVersion),
      (true, false) => pullIos(env),
      (false, true) => pushIosScreenshots(env, marketingVersion: marketingVersion),
      (true, true) => pullIosScreenshots(env),
    };
  }

  printSection('Done');
  stdout.writeln(isPull ? 'Live listings pulled. Review them with `git status` and `git diff`.' : 'Listings pushed.');
}

const iosBundleId = 'app.luxbible.app';
const iosMetadataPath = 'ios/fastlane/metadata';
const iosScreenshotsPath = 'ios/fastlane/screenshots';
const androidMetadataPath = 'android/fastlane/metadata/android';
const androidScreenshotTypes = [
  'phoneScreenshots',
  'sevenInchScreenshots',
  'tenInchScreenshots',
  'tvScreenshots',
  'wearScreenshots',
];

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
      await runDeliver([
        ...appStoreConnectArgs(keyPath),
        '--app_version',
        marketingVersion,
        '--force',
        'true',
        '--skip_binary_upload',
        'true',
        '--skip_screenshots',
        'true',
        '--submit_for_review',
        'false',
        '--run_precheck_before_submit',
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

Future<void> pushIosScreenshots(Map<String, String> env, {required String marketingVersion}) {
  requireScreenshots(getImages(iosScreenshotsPath), path: iosScreenshotsPath);
  return withAppStoreConnectKey(env, (keyPath) async {
    stdout.writeln(
      'Replacing the $marketingVersion screenshots of each language that has a folder in $iosScreenshotsPath.',
    );
    await runDeliver([
      ...appStoreConnectArgs(keyPath),
      '--app_version',
      marketingVersion,
      '--screenshots_path',
      File(iosScreenshotsPath).absolute.path,
      '--overwrite_screenshots',
      'true',
      '--force',
      'true',
      '--skip_metadata',
      'true',
      '--skip_binary_upload',
      'true',
      '--submit_for_review',
      'false',
      '--run_precheck_before_submit',
      'false',
    ]);
  });
}

Future<void> pullIosScreenshots(Map<String, String> env) {
  requireCommitted(iosScreenshotsPath);
  return withAppStoreConnectKey(
    env,
    (keyPath) => withTemporaryDirectory((directory) async {
      final downloadPath = '$directory/screenshots';
      await runFastlane([
        'deliver',
        'download_screenshots',
        ...appStoreConnectArgs(keyPath),
        '--screenshots_path',
        downloadPath,
        '--use_live_version',
        'true',
      ]);
      mirrorScreenshots(
        getLanguages(
          iosMetadataPath,
        ).map((language) => (from: '$downloadPath/$language', to: '$iosScreenshotsPath/$language')),
      );
    }),
  );
}

Future<void> pushAndroid(Map<String, String> env, {required String buildNumber}) async {
  requireChangelogs(buildNumber: buildNumber);
  stdout.write(
    'Push the Google Play listing for ${getLanguages(androidMetadataPath).join(', ')} and the build $buildNumber release notes on the '
    '$playReleaseNotesTrack track? This sends the changes for review. [y/N] ',
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

// Play attaches listing uploads to a release, so this needs the build on the internal track too.
Future<void> pushAndroidScreenshots(Map<String, String> env, {required String buildNumber}) async {
  requireScreenshots(androidScreenshots, path: androidMetadataPath);
  stdout.write(
    'Replace the Google Play screenshots of each language that has screenshot folders in $androidMetadataPath? '
    'This sends the changes for review. [y/N] ',
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
    '--skip_upload_metadata',
    'true',
    '--skip_upload_changelogs',
    'true',
    '--skip_upload_images',
    'true',
    '--sync_image_upload',
    'true',
  ]);
}

Future<void> pullAndroidScreenshots(Map<String, String> env) {
  requireCommitted('$androidMetadataPath/*/images');
  return withTemporaryDirectory((directory) async {
    final downloadPath = '$directory/metadata';
    await runFastlane(['supply', 'init', ...playArgs(env), '--metadata_path', downloadPath]);
    mirrorScreenshots(
      getLanguages(androidMetadataPath).expand(
        (language) => androidScreenshotTypes.map(
          (type) => (from: '$downloadPath/$language/images/$type', to: '$androidMetadataPath/$language/images/$type'),
        ),
      ),
    );
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

Iterable<String> getLanguages(String metadataPath) =>
    Directory(metadataPath).listSync().whereType<Directory>().map((dir) => dir.path.split('/').last);

// supply pushes blank release notes instead of failing when a language has no notes for the build.
void requireChangelogs({required String buildNumber}) {
  final missing = getLanguages(androidMetadataPath)
      .map((language) => '$androidMetadataPath/$language/changelogs/$buildNumber.txt')
      .where((path) => !File(path).existsSync());
  if (missing.isNotEmpty) {
    fail('Missing Google Play release notes for build $buildNumber:\n${missing.map((path) => '  $path').join('\n')}');
  }
}

void requireScreenshots(Iterable<File> screenshots, {required String path}) {
  if (screenshots.isEmpty) {
    fail('No screenshots found in $path. Add them, or start from the live ones with --pull --screenshots.');
  }
}

Iterable<File> get androidScreenshots =>
    getImages(androidMetadataPath).where((file) => androidScreenshotTypes.contains(file.parent.path.split('/').last));

Iterable<File> getImages(String path) => Directory(path).existsSync()
    ? Directory(path).listSync(recursive: true).whereType<File>().where((file) => imageExtension.hasMatch(file.path))
    : [];

final imageExtension = RegExp(r'\.(png|jpe?g)$', caseSensitive: false);

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
      .where((file) => file.path.endsWith('.txt'))
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

// Only languages the repo already lists are mirrored, so a pull never adds a store locale.
void mirrorScreenshots(Iterable<({String from, String to})> folders) {
  for (final folder in folders) {
    final target = Directory(folder.to);
    if (target.existsSync()) target.deleteSync(recursive: true);

    final images = getImages(folder.from).toList();
    if (images.isNotEmpty) target.createSync(recursive: true);
    for (final image in images) {
      image.copySync('${target.path}/${image.uri.pathSegments.last}');
    }
  }

  final pulled = folders
      .map((folder) => (path: folder.to, count: getImages(folder.to).length))
      .where((folder) => folder.count > 0)
      .toList();
  stdout.writeln(
    pulled.isEmpty
        ? 'No live screenshots were found.'
        : 'Pulled the live screenshots:\n${pulled.map((folder) => '  ${folder.path}: ${folder.count}').join('\n')}',
  );
}

// Without fastlane/metadata in the working directory, deliver offers to run its setup, which
// downloads the live listing over the local files instead of pushing them.
Future<void> runDeliver(List<String> args) => runFastlane([
  'deliver',
  ...args,
  '--metadata_path',
  File(iosMetadataPath).absolute.path,
], workingDirectory: File(iosMetadataPath).parent.parent.path);

Future<void> runFastlane(List<String> args, {String? workingDirectory}) async {
  stdout.writeln('\$ fastlane ${args.join(' ')}');
  final process = await Process.start(
    'fastlane',
    args,
    workingDirectory: workingDirectory,
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
