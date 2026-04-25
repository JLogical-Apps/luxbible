import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:utils_core/utils_core.dart';

extension StringExtensions on String {
  String get onlyLetters => replaceAll(RegExp(r"[^a-zA-Z ]"), "");
  bool get isLetterOnly => contains(RegExp(r"[^a-zA-Z'\-]"));

  bool get isStrongId => RegExp(r'^[GH]\d{1,4}$').hasMatch(this);

  Text toText() => Text(this);

  List<String> get keywords =>
      trim().toLowerCase().split(RegExp(r'[\s-]+')).where((string) => string.isNotBlank).toList();

  bool passesSearch(List<String> searchKeywords, {double similarityLimit = 0.88}) => keywords.every(
    (word) => searchKeywords.any((sk) => sk.startsWith(word) || ratio(word, sk) / 100 > similarityLimit),
  );
}
