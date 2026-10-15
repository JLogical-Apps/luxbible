import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:material_symbols_icons/symbols.dart';

enum WhatsNewHighlight {
  planToolbar,
  planTransfer,
  completeThrough,
  navigationSettings,
  tutorials;

  // Bumped by hand only for releases worth announcing, so bug-fix updates don't show the dot.
  static const releaseVersion = '1.10.0';

  String title() => switch (this) {
    planToolbar => t.whatsNew.planToolbarTitle,
    planTransfer => t.whatsNew.planTransferTitle,
    completeThrough => t.whatsNew.completeThroughTitle,
    navigationSettings => t.whatsNew.navigationSettingsTitle,
    tutorials => t.whatsNew.tutorialsTitle,
  };

  String description() => switch (this) {
    planToolbar => t.whatsNew.planToolbarDescription,
    planTransfer => t.whatsNew.planTransferDescription,
    completeThrough => t.whatsNew.completeThroughDescription,
    navigationSettings => t.whatsNew.navigationSettingsDescription,
    tutorials => t.whatsNew.tutorialsDescription,
  };

  IconData get icon => switch (this) {
    planToolbar => Symbols.toolbar,
    planTransfer => Symbols.file_export,
    completeThrough => Symbols.done_all,
    navigationSettings => Symbols.explore,
    tutorials => Symbols.waving_hand,
  };
}
