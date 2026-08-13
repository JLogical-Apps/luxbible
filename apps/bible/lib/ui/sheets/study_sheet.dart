import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class StudySheet {
  static Future<void> show(
    BuildContext context, {
    required String regionFormat,
    required VerseSelection verseSelection,
    required RegionType regionType,
    required Function(VerseSelection) onNavigateToVerseSelection,
    Function(StudyPanel)? onAddStudyPanel,
  }) => context.showStyledSheet(
    (context) => StyledSheet(
      title: t.labels.study.toText(),
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
                  regionFormat: regionFormat,
                  verseSelection: verseSelection,
                  onNavigateToVerseSelection: onNavigateToVerseSelection,
                  onAddStudyPanel: onAddStudyPanel,
                  user: ref.read(userProvider),
                );
              },
            ),
          )
          .toList(),
    ),
  );
}
