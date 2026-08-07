import 'package:bible/models/user/user.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CompareSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    BibleTranslation? translation,
    required User user,
  }) {
    if (translation != null) {
      return [
        Padding(
          padding: .all(16),
          child: _bibleParagraphs(translation: translation, verseSelection: verseSelection),
        ),
      ];
    }
    final bibles = user.biblesOrDefault;
    return StyledDivider(height: 2).wrapPositioned(
      bibles
          .map<Widget>(
            (translation) => StyledStickyHeader.child(
              title: translation.title().toText(),
              child: _bibleParagraphs(translation: translation, verseSelection: verseSelection),
            ),
          )
          .toList(),
    );
  }

  static Widget _bibleParagraphs({required BibleTranslation translation, required VerseSelection verseSelection}) =>
      verseSelection.isInTranslation(translation)
      ? PassageBuilder(
          verseSelection: verseSelection,
          translation: translation,
          contentBuilder: (context, passage) => Padding(padding: .only(bottom: 16), child: passage),
        )
      : Padding(
          padding: .only(bottom: 16),
          child: StyledTile.message(
            leading: Symbols.translate.toIcon(),
            title: t.compare.unavailable(translation: translation.fullName()).toText(),
          ),
        );
}
