import 'dart:io' hide Platform;
import 'dart:io' as io;
import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import '../lib/api.dart';
import '../lib/clipboard.dart';
import '../lib/environment.dart';
import '../lib/media.dart';
import '../lib/post.dart';
import '../lib/progress.dart';
import '../lib/providers.dart';

String getAccountVariable(Platform platform) =>
    '${platform == .tiktok || platform == .youtube ? 'ZERNIO' : 'WOOPSOCIAL'}_${platform.name.toUpperCase()}_ACCOUNT_ID';

Provider getProvider(Platform platform) => switch (platform) {
  .tiktok || .youtube => Zernio(
    Api('https://zernio.com/api/v1', getRequiredEnvironment('ZERNIO_API_KEY')),
    getRequiredEnvironment(getAccountVariable(platform)),
    platform,
  ),
  .instagram || .facebook => WoopSocial(
    Api(
      'https://api.woopsocial.com/v1',
      getRequiredEnvironment('WOOPSOCIAL_API_KEY'),
    ),
    getRequiredEnvironment(getAccountVariable(platform)),
    getRequiredEnvironment('WOOPSOCIAL_PROJECT_ID'),
    platform,
  ),
};

Directory getRepository() {
  var directory = File.fromUri(io.Platform.script).parent;
  while (!File(p.join(directory.path, 'AGENTS.md')).existsSync() ||
      !Directory(p.join(directory.path, 'context')).existsSync()) {
    final parent = directory.parent;
    if (parent.path == directory.path)
      throw FormatException('Could not locate repository from script path');
    directory = parent;
  }
  return directory;
}

class PublishResult {
  final bool isSuccess;
  final String summary;
  final List<String> notes;
  final String? comment;
  PublishResult(this.isSuccess, this.summary, this.notes, {this.comment});
}

Future<PublishResult> publishPost(
  Post post,
  Platform platform,
  Progress progress,
  String label, {
  bool isAi = false,
  Provider Function()? createProvider,
}) async {
  Provider? provider;
  Directory? coverDirectory;
  var hasSubmitted = false;
  String? providerPostId;
  final notes = <String>[];
  try {
    progress.update(label, 'Checking media and account');
    var prepared = await post.prepare(platform, isAi: isAi);
    var media = await Future.wait(prepared.files.map(MediaInfo.read));
    final validation = getValidation(prepared, media);
    notes.addAll(validation.warnings);
    if (validation.errors.isNotEmpty)
      throw FormatException(validation.errors.join('; '));
    provider = createProvider?.call() ?? getProvider(platform);
    final account = await provider.getDestination(prepared, media);
    notes.add('Account: ${account.summary}');
    if (prepared.coverTimestampMs case final timestamp?
        when platform == .instagram) {
      coverDirectory = await Directory.systemTemp.createTemp(
        'lux-social-cover-',
      );
      final cover = await getVideoCover(
        prepared.media.single,
        timestamp,
        coverDirectory,
      );
      prepared = prepared.getWithCover(cover);
      media = await Future.wait(prepared.files.map(MediaInfo.read));
    }
    provider.api.onUpload = (bytes) => progress.addBytes(label, bytes);
    progress.startUpload(
      label,
      media
              .take(prepared.media.length)
              .fold<int>(0, (total, item) => total + item.bytes) +
          (prepared.isVideo &&
                  (platform == .instagram || platform == .tiktok) &&
                  prepared.cover != null
              ? media.last.bytes
              : 0),
    );
    final body = await provider.upload(prepared, media);
    progress.update(label, 'Validating upload');
    final remoteValidation = await provider.validate(body);
    notes.addAll(remoteValidation.warnings);
    if (remoteValidation.errors.isNotEmpty)
      throw FormatException(remoteValidation.errors.join('; '));
    progress.update(label, 'Publishing');
    hasSubmitted = true;
    final initial = await provider.publish(body);
    providerPostId = initial.id;
    progress.update(label, 'Processing delivery');
    var delivery = await provider.poll(initial);
    if (delivery.isSuccess && platform == .tiktok && delivery.url == null) {
      progress.update(label, 'Published, resolving link');
      final clock = Stopwatch()..start();
      while (delivery.url == null && clock.elapsed < Duration(minutes: 2)) {
        await Future<void>.delayed(Duration(seconds: 10));
        try {
          delivery = await provider.getDelivery(initial.id);
        } catch (_) {
          break;
        }
      }
    }
    notes.addAll(provider.warnings);
    if (!delivery.isSuccess) {
      progress.update(label, delivery.isTerminal ? 'Failed' : 'Timed out');
      return PublishResult(
        false,
        '${delivery.summary}; check dashboard and native account before retrying',
        notes,
      );
    }
    progress.update(label, 'Published');
    final comment = await provider.finishComment(prepared, delivery);
    notes.add(comment.summary);
    return PublishResult(
      true,
      delivery.summary,
      notes,
      comment: comment.textToCopy,
    );
  } catch (error) {
    progress.update(label, 'Failed');
    return PublishResult(
      false,
      '${getSafeMessage(error)}${hasSubmitted ? '; delivery uncertain or failed, inspect dashboard${providerPostId == null ? '' : ' post $providerPostId'} before retrying' : '; no publish request sent'}',
      notes,
    );
  } finally {
    provider?.api.close();
    if (coverDirectory != null) {
      try {
        await coverDirectory.delete(recursive: true);
      } catch (error) {
        notes.add('Temporary cover cleanup failed: ${getSafeMessage(error)}');
      }
    }
  }
}

Future<void> main(List<String> args) async {
  Progress? progress;
  try {
    final parser = getParser();
    final options = parser.parse(args);
    if (args.isEmpty || options.flag('help')) {
      stdout.writeln(
        'From tools/socials: dart run bin/publish.dart <post-id> [options]\n${parser.usage}',
      );
      exitCode = args.isEmpty ? 64 : 0;
      return;
    }
    if (options.rest.length != 1 ||
        !RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9_-]*$').hasMatch(options.rest.single))
      throw FormatException(
        'Provide one explicit post ID containing letters, digits, hyphens or underscores',
      );
    final postId = options.rest.single;
    final selected = options
        .multiOption('platform')
        .map(Platform.values.byName)
        .toSet();
    if (selected.isEmpty) throw FormatException('Select at least one platform');
    final root = getRepository();
    loadEnvironment(p.join(root.path, 'tools', 'socials', '.env'));
    final isPosted = options.flag('posted');
    final parent = Directory(
      p.join(root.path, 'socials', isPosted ? 'posted' : 'pending'),
    );
    final folder = Directory(p.join(parent.path, postId));
    if (await folder.resolveSymbolicLinks() !=
        p.join(await parent.resolveSymbolicLinks(), postId))
      throw FormatException('Post folder must not be a symlink');
    final post = await Post.load(folder);
    final jobs = selected.toList();
    final display = Progress(jobs.map((platform) => platform.name).toList());
    progress = display;
    final results = await Future.wait(
      jobs.map(
        (job) =>
            publishPost(post, job, display, job.name, isAi: options.flag('ai')),
      ),
    );
    display.finish();
    stdout.writeln('\nResults:');
    for (final (index, job) in jobs.indexed) {
      final result = results[index];
      stdout.writeln('${job.name}: ${getSafeMessage(result.summary)}');
      result.notes.toSet().forEach(
        (note) => stdout.writeln('  ${getSafeMessage(note)}'),
      );
    }
    final comments = jobs.indexed
        .where((entry) => results[entry.$1].comment != null)
        .map((entry) => '${entry.$2.name}:\n${results[entry.$1].comment}')
        .join('\n\n');
    if (comments.isNotEmpty) {
      stdout.writeln('\nManual comments:\n$comments');
      stdout.writeln(
        await copyToClipboard(comments)
            ? 'Manual comments copied to clipboard.'
            : 'Clipboard unavailable; copy the comments above.',
      );
    }
    if (results.every((result) => result.isSuccess)) {
      if (!isPosted) {
        final target = p.join(root.path, 'socials', 'posted', postId);
        await Directory(p.dirname(target)).create(recursive: true);
        if (await FileSystemEntity.type(target, followLinks: false) !=
            FileSystemEntityType.notFound)
          throw FormatException(
            'Posted folder already exists; nothing overwritten',
          );
        await folder.rename(target);
        stdout.writeln('Moved to $target');
      }
    } else {
      exitCode = 1;
      stdout.writeln(
        'Folder retained at ${folder.path}. Retry only intended destinations after checking delivery.',
      );
    }
  } catch (error) {
    progress?.finish();
    stderr.writeln('Failed: ${getSafeMessage(error)}');
    exitCode = 1;
  }
}

ArgParser getParser() => ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage.')
  ..addMultiOption(
    'platform',
    allowed: Platform.values.map((p) => p.name),
    defaultsTo: Platform.values.map((p) => p.name),
    help: 'Destinations, separated by commas. Repeated options combine.',
  )
  ..addFlag(
    'ai',
    negatable: false,
    help: 'Enable AI media disclosure on TikTok and YouTube. Default: off.',
  )
  ..addFlag(
    'posted',
    negatable: false,
    help: 'Read from posted instead of pending; never move the folder.',
  );
