import 'dart:async';
import 'dart:io';
import 'api.dart';

class Progress {
  final Map<String, String> statuses;
  final bytes = <String, int>{};
  final totals = <String, int>{};
  Timer? timer;
  var hasRendered = false;
  var isFinished = false;
  Progress(List<String> labels)
    : statuses = {for (final label in labels) label: 'Waiting'} {
    if (stdout.hasTerminal) {
      render();
      timer = Timer.periodic(Duration(milliseconds: 150), (_) => render());
    }
  }

  void update(String label, String status) {
    statuses[label] = status;
    if (!stdout.hasTerminal) stdout.writeln('$label: $status');
  }

  void startUpload(String label, int total) {
    bytes[label] = 0;
    totals[label] = total;
    update(label, 'Uploading');
  }

  void addBytes(String label, int count) =>
      bytes.update(label, (n) => n + count);

  void render() {
    if (hasRendered) stdout.write('\x1b[${statuses.length}A');
    for (final entry in statuses.entries) {
      final percentage =
          entry.value == 'Uploading' && (totals[entry.key] ?? 0) > 0
          ? ' ${(100 * (bytes[entry.key] ?? 0) / totals[entry.key]!).clamp(0, 100).toStringAsFixed(0)}% sent'
          : '';
      final line =
          '${entry.key.padRight(16)} ${getSafeMessage(entry.value)}$percentage';
      final width = stdout.terminalColumns;
      stdout.writeln(
        '\x1b[2K${line.substring(0, line.length.clamp(0, width > 1 ? width - 1 : 1))}',
      );
    }
    hasRendered = true;
  }

  void finish() {
    if (isFinished) return;
    isFinished = true;
    timer?.cancel();
    if (stdout.hasTerminal) render();
  }
}
