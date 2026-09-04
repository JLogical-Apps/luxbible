import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/compare_settings_page.dart';
import 'package:bible/ui/sheets/commentary_sheet.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/sheets/cross_references_sheet.dart';
import 'package:bible/ui/sheets/interlinear_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/ui/widgets/pin_study_panel_button.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:style/style.dart';

enum StudyAction {
  compare,
  interlinear,
  commentary,
  crossReferences;

  String title() => switch (this) {
    compare => t.studyActions.compare,
    interlinear => t.studyActions.interlinear,
    commentary => t.studyActions.commentary,
    crossReferences => t.studyActions.crossReferences,
  };

  String description({required String? regionFormat, required RegionType regionType}) {
    final regionText = regionFormat ?? regionType.formatThis();
    return switch (this) {
      compare => t.studyActions.compareDescription(region: regionText),
      interlinear => t.studyActions.interlinearDescription(region: regionText),
      commentary => t.studyActions.commentaryDescription(region: regionText),
      crossReferences => t.studyActions.crossReferencesDescription(region: regionText),
    };
  }

  IconData get icon => switch (this) {
    compare => Symbols.text_compare,
    interlinear => Symbols.dictionary,
    commentary => Symbols.tooltip_2,
    crossReferences => Symbols.graph_4,
  };

  BibleTranslation? getTranslationOverride({required User user}) => switch (this) {
    interlinear => user.translation.isStudy ? null : user.studyTranslation,
    crossReferences => user.translation.isLocal ? null : user.studyTranslation,
    _ => null,
  };

  Future<void> onPressed(
    BuildContext context, {
    required VerseSelection verseSelection,
    required String regionFormat,
    required Function(VerseSelection) onNavigateToVerseSelection,
    Function(StudyPanel)? onAddStudyPanel,
    required User user,
  }) async {
    switch (this) {
      case .interlinear:
        context.showStyledSheetWithBreadcrumbs(breadcrumbText: regionFormat, (context, _) {
          final user = ref.read(userProvider);

          final tabController = useTabController(
            initialLength: InterlinearDirection.values.length,
            initialIndex: user.interlinearDirection.index,
          );

          useOnListenableChange(tabController, () {
            final interlinearDirection = InterlinearDirection.values[tabController.index];
            // Read fresh so the comparison reflects the latest saved preference.
            if (interlinearDirection != ref.read(userProvider).interlinearDirection) {
              ref.updateUser((user) => user.copyWith(interlinearDirection: interlinearDirection));
            }
          });

          final interlinearDirection =
              InterlinearDirection.values[useListenableSelector(tabController, () => tabController.index)];

          return StyledSheet.builder(
            title: t.labels.interlinear.toText(),
            subtitle: Row(
              mainAxisAlignment: .center,
              spacing: 8,
              children: [
                regionFormat.toText(),
                if (user.translation != user.studyTranslation)
                  StyledTag.sm(child: user.studyTranslation.title().toText()),
              ],
            ),
            trailing: onAddStudyPanel == null
                ? null
                : PinStudyPanelButton(
                    studyPanel: .interlinear(direction: interlinearDirection),
                    onAddStudyPanel: onAddStudyPanel,
                  ),
            aboveDivider: StyledTabBar.fill(
              tabController: tabController,
              tabTitles: InterlinearDirection.values.map((direction) => direction.title().toText()).toList(),
            ),
            showDivider: false,
            childrenBuilder: (context, ref) => InterlinearSheet.buildSheetChildren(
              context,
              ref,
              verseSelection: verseSelection,
              onNavigateToVerseSelection: onNavigateToVerseSelection,
              direction: interlinearDirection,
              user: user,
            ),
          );
        });
      case .commentary:
        context.showStyledSheet((context, ref) {
          final user = ref.watch(userProvider);
          final tabController = useTabController(
            initialLength: user.commentariesOrDefault.length,
            keys: [user.commentariesOrDefault.length],
          );
          final index = useListenableSelector(tabController, () => tabController.index);
          final selectedCommentary = user.commentariesOrDefault[index];

          return StyledSheet.builder(
            title: title().toText(),
            subtitle: regionFormat.toText(),
            trailing: onAddStudyPanel == null
                ? null
                : StyledCircleButton.md(
                    child: Symbols.more_vert.toIcon(),
                    onPressed: () => context.showStyledSheet(
                      (context, _) => StyledSheet(
                        children: [
                          StyledListItem(
                            title: 'Edit Commentaries'.toText(),
                            leading: Symbols.tune.toIcon(),
                            onPressed: () => context.pushReplacement(CommentariesPage()),
                          ),
                          StyledListItem(
                            title: 'Pin ${selectedCommentary.title()} Commentary as a Study Panel'.toText(),
                            leading: Symbols.push_pin.toIcon(),
                            onPressed: () {
                              context.pop();
                              context.pop();
                              onAddStudyPanel(.commentary(type: selectedCommentary));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            shrinkWrap: false,
            aboveDivider: StyledTabBar.scrollable(
              tabController: tabController,
              tabTitles: user.commentariesOrDefault.map((type) => type.title().toText()).toList(),
            ),
            showDivider: false,
            childrenKey: ValueKey(selectedCommentary),
            childrenWrapper: (context, child) => SwipeGestureDetector(
              index: () => index,
              maxIndex: tabController.length,
              onSwipe: (newIndex) => tabController.animateTo(
                newIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
              ),
              child: child,
            ),
            childrenBuilder: (context, ref) => CommentarySheet.buildSheetChildren(
              context,
              ref,
              verseSelection: verseSelection,
              commentaryType: selectedCommentary,
              onNavigateToVerseSelection: (verseSelection) {
                context.pop();
                onNavigateToVerseSelection(verseSelection);
              },
            ),
          );
        });
      case .compare:
        context.showStyledSheet((context, ref) {
          final user = ref.watch(userProvider);
          return StyledSheet(
            title: title().toText(),
            subtitle: regionFormat.toText(),
            trailing: StyledCircleButton.md(
              child: Symbols.tune.toIcon(),
              onPressed: () => context.push(CompareSettingsPage()),
            ),
            children: CompareSheet.buildSheetChildren(
              context,
              verseSelection: verseSelection,
              user: user,
              onAddStudyPanel: onAddStudyPanel,
            ),
          );
        });
      case .crossReferences:
        ref.markOnboardingStep(.crossReferences);
        context.showStyledSheet(
          (context, _) => StyledSheet(
            title: title().toText(),
            subtitle: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  regionFormat.toText(),
                  if (getTranslationOverride(user: user) case final override?)
                    StyledTag.sm(child: override.title().toText()),
                ],
              ),
            ),
            children: CrossReferencesSheet.buildSheetChildren(
              context,
              verseSelection: verseSelection,
              onNavigateToVerseSelection: onNavigateToVerseSelection,
              user: user,
            ),
            trailing: onAddStudyPanel != null
                ? PinStudyPanelButton(studyPanel: .crossReferences(), onAddStudyPanel: onAddStudyPanel)
                : null,
          ),
        );
    }
  }
}
