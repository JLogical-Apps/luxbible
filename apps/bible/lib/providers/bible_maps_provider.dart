import 'dart:convert';

import 'package:bible/models/bible_map.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_maps_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<BibleMap>> bibleMaps(Ref ref) async =>
    (jsonDecode(await rootBundle.loadString('assets/maps/tyndale.json')) as List)
        .map((map) => BibleMap.fromJson(map))
        .toList();
