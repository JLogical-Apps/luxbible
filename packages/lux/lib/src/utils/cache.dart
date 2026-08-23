import 'dart:convert';
import 'dart:io';

import 'package:lux/src/services/path_service.dart';
import 'package:utils_core/utils_core.dart';

class Cache {
  static Future<T> fetch<T extends Object>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
    required Duration duration,
    required Future<T> Function() source,
    required Paths? paths,
  }) async {
    if (paths == null) return source();

    final file = paths.applicationCache - '$path.json';
    final cachedValue = await _getCachedValue(file: file, duration: duration, fromJson: fromJson);
    if (cachedValue != null) return cachedValue;

    final value = await source();
    await _storeValue(file: file, value: value, toJson: toJson);
    return value;
  }

  static Future<T?> _getCachedValue<T extends Object>({
    required File file,
    required Duration duration,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    if (!await file.exists()) return null;

    try {
      final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      final cachedTime = DateTime.parse(json['cachedTime'] as String);
      if (!DateTime.now().isBefore(cachedTime.add(duration))) {
        await file.delete();
        return null;
      }

      return fromJson(json['value'] as Map<String, dynamic>);
    } catch (_) {
      await _deleteIfExists(file);
      return null;
    }
  }

  static Future<void> _storeValue<T extends Object>({
    required File file,
    required T value,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      await file.create(recursive: true);
      await file.writeAsString(
        jsonEncode({'cachedTime': DateTime.now().toUtc().toIso8601String(), 'value': toJson(value)}),
      );
    } catch (_) {}
  }

  static Future<void> _deleteIfExists(File file) async {
    try {
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }
}
