import 'package:bible/services/bible_plan_file_service.dart';
import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:material_symbols_icons/symbols.dart';

enum WhatsNewHighlight {
  advent,
  planImprovements,
  polish;

  // Bumped by hand only for releases worth announcing, so bug-fix updates don't show the dot.
  static const releaseVersion = '1.12.0';

  String title() => switch (this) {
    advent => t.whatsNew.adventTitle,
    planImprovements => t.whatsNew.planImprovementsTitle,
    polish => t.whatsNew.polishTitle,
  };

  String description() => switch (this) {
    advent => t.whatsNew.adventDescription,
    planImprovements => t.whatsNew.planImprovementsDescription,
    polish => t.whatsNew.polishDescription,
  };

  IconData get icon => switch (this) {
    advent => Symbols.candle,
    planImprovements => Symbols.auto_stories,
    polish => Symbols.auto_awesome,
  };

  Uri? get learnMoreUri => switch (this) {
    planImprovements => biblePlanFormatUri,
    advent || polish => null,
  };
}
