import 'dart:convert';
import 'dart:io';

const ffmpegBin = 'ffmpeg';
const ffprobeBin = 'ffprobe';

class FfmpegException implements Exception {
  const FfmpegException(this.binary, this.args, this.stderr);

  final String binary;
  final List<String> args;
  final String stderr;

  @override
  String toString() => '$binary ${args.join(' ')}\n$stderr';
}

Future<String> runFfprobe(List<String> args) async {
  final result = await Process.run(ffprobeBin, ['-v', 'error', ...args]);
  if (result.exitCode != 0) throw FfmpegException(ffprobeBin, args, result.stderr as String);
  return result.stdout as String;
}

Future<String> runFfmpeg(List<String> args, {Duration? total, void Function(double)? onProgress}) async {
  final full = ['-hide_banner', '-v', 'error', '-nostdin', '-y', ...args];
  final process = await Process.start(ffmpegBin, [...full, '-progress', 'pipe:1', '-nostats']);

  final errors = StringBuffer();
  final drain = process.stderr.transform(utf8.decoder).forEach(errors.write);

  if (total case final total? when onProgress != null) {
    await process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .where((line) => line.startsWith('out_time_us='))
        .map((line) => int.tryParse(line.split('=').last))
        .forEach((us) {
          if (us != null) onProgress((us / total.inMicroseconds).clamp(0.0, 1.0));
        });
  } else {
    await process.stdout.drain<void>();
  }

  await drain;
  if (await process.exitCode != 0) throw FfmpegException(ffmpegBin, full, errors.toString());
  return errors.toString();
}

Future<String> runFfmpegCapturingStderr(List<String> args) async {
  final process = await Process.start(ffmpegBin, ['-hide_banner', '-nostdin', ...args]);
  final errors = StringBuffer();
  await Future.wait([process.stderr.transform(utf8.decoder).forEach(errors.write), process.stdout.drain<void>()]);
  await process.exitCode;
  return errors.toString();
}

Future<Duration> probeDuration(String path) async {
  final out = await runFfprobe(['-show_entries', 'format=duration', '-of', 'csv=p=0', path]);
  return Duration(microseconds: (double.parse(out.trim()) * 1000000).round());
}
