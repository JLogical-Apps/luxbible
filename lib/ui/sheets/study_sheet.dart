import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudySheet {
  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required String regionFormat,
    required VerseSelection verseSelection,
    required RegionType regionType,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheet(
    (context) => StyledSheet(
      title: 'Study'.toText(),
      subtitle: regionFormat.toText(),
      children: StudyAction.values
          .map(
            (action) => StyledListItem.navigation(
              title: action.title().toText(),
              subtitle: action.description(regionFormat: regionFormat, regionType: regionType).toText(),
              leading: action.icon.toIcon(),
              onPressed: () {
                context.pop();
                action.onPressed(
                  context,
                  ref,
                  regionFormat: regionFormat,
                  verseSelection: verseSelection,
                  onNavigateToVerseSelection: onNavigateToVerseSelection,
                );
              },
            ),
          )
          .toList(),
    ),
  );
}
