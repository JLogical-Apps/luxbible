import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/widgets/linked_study_panel.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class LinkedCompareStudyPanel extends ConsumerWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;

  final Reference? passageTopReference;
  final Function(Reference) onScrollToReference;

  final bool isActive;
  final bool showDragHandle;

  final Function() onClose;

  const LinkedCompareStudyPanel({
    super.key,
    required this.chapterReference,
    required this.translation,
    required this.passageTopReference,
    required this.onScrollToReference,
    required this.isActive,
    required this.showDragHandle,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return LinkedStudyPanel(
      chapterReference: chapterReference,
      passageTopReference: passageTopReference,
      onScrollToReference: onScrollToReference,
      isActive: isActive,
      showDragHandle: showDragHandle,
      title: chapterReference.format().toText(),
      subtitle: 'Compare with ${translation.title()}'.toText(),
      leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: onClose),
      childrenBuilder: (context, ref, keyByReference) => CompareSheet.buildSheetChildren(
        context,
        verseSelection: chapterReference.toVerseSelection(),
        translation: translation,
        user: user,
        keyByReference: keyByReference,
      ),
    );
  }
}
