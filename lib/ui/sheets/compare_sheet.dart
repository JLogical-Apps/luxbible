import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CompareSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    BibleTranslation? translation,
    required User user,
    Map<Reference, GlobalKey>? keyByReference,
  }) {
    if (translation != null) {
      return [
        Padding(
          padding: .all(16),
          child: _bibleParagraphs(
            translation: translation,
            verseSelection: verseSelection,
            keyByReference: keyByReference,
          ),
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

  static Widget _bibleParagraphs({
    required BibleTranslation translation,
    required VerseSelection verseSelection,
    Map<Reference, GlobalKey>? keyByReference,
  }) => verseSelection.isInTranslation(translation)
      ? PassageBuilder(
          verseSelection: verseSelection,
          translation: translation,
          showLoading: true,
          keyByReference: keyByReference,
          contentBuilder: (context, passage) => Padding(padding: .only(bottom: 16), child: passage),
        )
      : Padding(
          padding: .only(bottom: 16),
          child: StyledTile.message(
            leading: Symbols.translate.toIcon(),
            title: "${translation.fullName()} doesn't include this selection.".toText(),
          ),
        );
}
