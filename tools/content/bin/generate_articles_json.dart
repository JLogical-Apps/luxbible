import 'dart:convert';

import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale_articles.dart';

void main() {
  for (final (output, source) in [('people', 'Profiles.xml'), ('themes', 'ThemeNotes.xml')]) {
    final file = appAssetFile('$output/tyndale.json', app: .bible)..parent.createSync(recursive: true);
    file.writeAsStringSync(jsonEncode(extractTyndaleArticles(source).map((article) => article.toJson()).toList()));
  }
}
