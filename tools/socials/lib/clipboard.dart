import 'dart:convert';
import 'dart:io';

Future<bool> copyToClipboard(String text) async {
  final commands = Platform.isMacOS
      ? [
          ['pbcopy'],
        ]
      : Platform.isWindows
      ? [
          ['clip.exe'],
        ]
      : [
          ['wl-copy'],
          ['xclip', '-selection', 'clipboard'],
        ];
  for (final command in commands) {
    try {
      final process = await Process.start(
        command.first,
        command.skip(1).toList(),
      );
      final output = process.stdout.drain();
      final errors = process.stderr.drain();
      process.stdin.add(utf8.encode(text));
      await process.stdin.close();
      final status = await process.exitCode;
      await Future.wait([output, errors]);
      if (status == 0) return true;
    } catch (_) {}
  }
  return false;
}
