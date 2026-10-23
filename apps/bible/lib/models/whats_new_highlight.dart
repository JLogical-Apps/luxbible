import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:material_symbols_icons/symbols.dart';

enum WhatsNewHighlight {
  highlightStyles,
  marginAnnotations,
  notebookFiles;

  // Bumped by hand only for releases worth announcing, so bug-fix updates don't show the dot.
  static const releaseVersion = '1.11.0';

  String title() => switch (this) {
    highlightStyles => t.whatsNew.highlightStylesTitle,
    marginAnnotations => t.whatsNew.marginAnnotationsTitle,
    notebookFiles => t.whatsNew.notebookFilesTitle,
  };

  String description() => switch (this) {
    highlightStyles => t.whatsNew.highlightStylesDescription,
    marginAnnotations => t.whatsNew.marginAnnotationsDescription,
    notebookFiles => t.whatsNew.notebookFilesDescription,
  };

  IconData get icon => switch (this) {
    highlightStyles => Symbols.format_ink_highlighter,
    marginAnnotations => Symbols.view_sidebar,
    notebookFiles => Symbols.book_2,
  };
}
