import 'package:collection/collection.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux_core.dart';

enum CommentaryType {
  tyndale,
  matthewHenry,
  jamiesonFaussetBrown,
  calvin;

  static const linkPrefix = 'commentary:';

  // Links take the form `commentary:matthewHenry/Isa.40.1-Isa.40.11`.
  static (CommentaryType, VerseSelection)? parseLink(String link) {
    if (!link.startsWith(linkPrefix)) return null;
    if (link.substring(linkPrefix.length).split('/') case [
      final name,
      final osisId,
    ] when VerseSelection.isOsisId(osisId)) {
      if (values.firstWhereOrNull((type) => type.name == name) case final type?) {
        return (type, VerseSelection.fromOsisId(osisId));
      }
    }
    return null;
  }

  String title() => switch (this) {
    tyndale => 'Tyndale Study Notes',
    matthewHenry => 'Matthew Henry',
    jamiesonFaussetBrown => 'Jamieson-Fausset-Brown',
    calvin => 'John Calvin',
  };

  String description() => switch (this) {
    tyndale => t.commentaryTypes.tyndaleDescription,
    matthewHenry => t.commentaryTypes.matthewHenryDescription,
    jamiesonFaussetBrown => t.commentaryTypes.jamiesonFaussetBrownDescription,
    calvin => t.commentaryTypes.calvinDescription,
  };
}
