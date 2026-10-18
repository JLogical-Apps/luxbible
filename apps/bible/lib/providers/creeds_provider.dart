import 'dart:convert';
import 'dart:isolate';

import 'package:bible/models/creed.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'creeds_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Creed>> creeds(Ref ref) async {
  final language = ref.watch(languageProvider);
  final translationsPath = 'assets/creeds/creeds_${language.code}.json';
  final hasTranslations = (await AssetManifest.loadFromAssetBundle(rootBundle)).listAssets().contains(translationsPath);

  final json = await rootBundle.loadString('assets/creeds/creeds.json', cache: false);
  final translationsJson = hasTranslations ? await rootBundle.loadString(translationsPath, cache: false) : '[]';
  return Isolate.run(() {
    final translationById = decodeCreeds(translationsJson).mapToMap((creed) => MapEntry(creed.id, creed));
    return decodeCreeds(json)
        .map((creed) => translationById[creed.id] ?? creed)
        .sorted((a, b) => a.sortYear.compareTo(b.sortYear).nullIfZero ?? a.title.compareTo(b.title));
  });
}

List<Creed> decodeCreeds(String json) => (jsonDecode(json) as List).map((creed) => Creed.fromJson(creed)).toList();
