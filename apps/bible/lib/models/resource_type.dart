import 'package:bible/models/article_collection.dart';
import 'package:bible/ui/pages/articles_page.dart';
import 'package:bible/ui/pages/bible_maps_page.dart';
import 'package:bible/ui/pages/creeds_page.dart';
import 'package:bible/ui/pages/videos_page.dart';
import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';

enum ResourceType {
  people,
  themes,
  dictionary,
  maps,
  videos,
  creeds;

  ArticleCollection? get articleCollection => switch (this) {
    people => .people,
    themes => .themes,
    dictionary => .dictionary,
    maps || videos || creeds => null,
  };

  String title() => switch (this) {
    people || themes || dictionary => articleCollection!.title(),
    maps => t.labels.maps,
    videos => t.labels.videos,
    creeds => t.labels.creeds,
  };

  String description() => switch (this) {
    people || themes || dictionary => articleCollection!.description(),
    maps => t.toolbarShortcuts.mapsDescription,
    videos => t.toolbarShortcuts.videosDescription,
    creeds => t.toolbarShortcuts.creedsDescription,
  };

  IconData get icon => switch (this) {
    people || themes || dictionary => articleCollection!.icon,
    maps => Symbols.map,
    videos => Symbols.smart_display,
    creeds => Symbols.history_edu,
  };

  StyledRoute<VerseSelection> get page => switch (this) {
    people || themes || dictionary => ArticlesPage(collection: articleCollection!),
    maps => BibleMapsPage(),
    videos => VideosPage(),
    creeds => CreedsPage(),
  };
}
