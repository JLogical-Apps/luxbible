import 'dart:convert';

import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale_dictionary.dart';

void main() {
  final droppedLinks = <String>[];
  final articles = extractTyndaleDictionary(
    onDroppedLink: (articleId, href, text) => droppedLinks.add('$articleId: `$href` ($text)'),
  );
  appAssetFile(
    'dictionary/tyndale.json',
    app: .bible,
  ).writeAsStringSync(jsonEncode(articles.map((article) => article.toJson()).toList()));
  print('Wrote ${articles.length} articles. Kept ${droppedLinks.length} unresolvable links as plain text:');
  droppedLinks.forEach(print);
}
