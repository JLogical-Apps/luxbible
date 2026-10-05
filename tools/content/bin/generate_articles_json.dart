import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale_articles.dart';
import 'package:lux_content_tools/tyndale_dictionary.dart';

void main() {
  final dictionaryLinks = readTyndaleDictionaryLinks();
  final articlesByOutput = {
    for (final (output, source) in [('people', 'Profiles.xml'), ('themes', 'ThemeNotes.xml')])
      output: extractTyndaleArticles(source, dictionaryLinks: dictionaryLinks),
  };

  final articleIds = articlesByOutput.values.flattened.map((article) => article.id).toSet();
  final dictionaryIds = readTyndaleDictionaryIds();
  final unknownIds = [
    ...dictionaryLinks.keys.whereNot(articleIds.contains),
    ...dictionaryLinks.values.flattened.whereNot(dictionaryIds.contains),
  ];
  if (unknownIds.isNotEmpty) {
    throw FormatException('Unknown IDs in dictionary_links.json: ${unknownIds.join(', ')}.');
  }

  articlesByOutput.forEach((output, articles) {
    final file = appAssetFile('$output/tyndale.json', app: .bible)..parent.createSync(recursive: true);
    file.writeAsStringSync(jsonEncode(articles.map((article) => article.toJson()).toList()));
  });
}
