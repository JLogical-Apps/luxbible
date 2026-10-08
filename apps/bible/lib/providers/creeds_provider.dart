import 'dart:convert';
import 'dart:isolate';

import 'package:bible/models/creed.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creeds_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Creed>> creeds(Ref ref) async {
  final json = await rootBundle.loadString('assets/creeds/creeds.json', cache: false);
  return Isolate.run(
    () =>
        (jsonDecode(json) as List).map((creed) => Creed.fromJson(creed)).toList()
          ..sort((a, b) => a.sortYear.compareTo(b.sortYear).nullIfZero ?? a.title.compareTo(b.title)),
  );
}
