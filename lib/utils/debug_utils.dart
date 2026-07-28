import 'dart:async';

import 'package:flutter/foundation.dart';

T time<T>(String prefix, T Function() operation) {
  final stopwatch = Stopwatch()..start();
  final result = operation();
  debugPrint('$prefix: ${stopwatch.elapsedMilliseconds}ms');
  return result;
}

Future<T> timeAsync<T>(String prefix, FutureOr<T> Function() operation) async {
  final stopwatch = Stopwatch()..start();
  final result = await operation();
  debugPrint('$prefix: ${stopwatch.elapsedMilliseconds}ms');
  return result;
}
