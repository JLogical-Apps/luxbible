import 'dart:convert';

import 'package:bible/models/video.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'videos_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<VideoCollection>> videoCollections(Ref ref) async =>
    (jsonDecode(await rootBundle.loadString('assets/videos/bibleproject.json')) as List)
        .map((collection) => VideoCollection.fromJson(collection))
        .toList();
