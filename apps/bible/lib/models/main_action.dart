import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:bible/ui/pages/dictionary_page.dart';
import 'package:bible/ui/pages/lexicon_page.dart';
import 'package:bible/ui/pages/more_page.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/sheets/bookmark_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:uuid/uuid.dart';

enum MainAction {
  audio(true),
  bookmark(true),
  study(true),
  studyPanel(false),
  search(false),
  resources(false),
  plans(true),
  more(true);

  final bool isTopLevel;

  const MainAction(this.isTopLevel);

  static List<MainAction> get topLevelActions => MainAction.values.where((action) => action.isTopLevel).toList();

  String title() => switch (this) {
    audio =>
      ref.read(audioBiblePlayerProvider(context: .bible)).isPlaying
          ? t.mainActions.pauseAudio
          : t.mainActions.playAudio,
    bookmark => t.mainActions.bookmark,
    study => t.mainActions.study,
    studyPanel => t.mainActions.addStudyPanel,
    search => t.mainActions.search,
    resources => t.mainActions.resources,
    plans => t.mainActions.plans,
    more => t.mainActions.more,
  };

  String description({User? user}) => switch (this) {
    audio => t.mainActions.audioDescription,
    bookmark =>
      user?.currentBookmark == null ? t.mainActions.bookmarkDescription : t.mainActions.manageBookmarkDescription,
    study => t.mainActions.studyDescription,
    studyPanel => t.mainActions.studyPanelDescription,
    search => t.mainActions.searchDescription,
    resources => t.mainActions.resourcesDescription,
    plans => t.mainActions.plansDescription,
    more => t.mainActions.moreDescription,
  };

  Widget buildIcon(BuildContext context, {User? user}) => switch (this) {
    audio => Consumer(
      builder: (context, ref, child) {
        final audioBiblePlayer = ref.watch(audioBiblePlayerProvider(context: .bible));
        final position = ref.watch(audioBiblePositionProvider).value;
        return Stack(
          clipBehavior: .none,
          children: [
            Icon(audioBiblePlayer.isPlaying ? Symbols.pause : Symbols.play_arrow),
            if (audioBiblePlayer.isActive && position != null && user?.audio.isOpen == true)
              if (audioBiblePlayer.duration case final duration? when duration != .zero)
                Positioned(
                  left: -4,
                  right: -4,
                  top: -4,
                  bottom: -4,
                  child: CircularProgressIndicator(
                    value: position.inMilliseconds / duration.inMilliseconds,
                    strokeWidth: 2,
                  ),
                ),
          ],
        );
      },
    ),
    bookmark => () {
      final bookmark = user?.currentBookmark;
      return bookmark == null
          ? Icon(Symbols.bookmark, fill: 0)
          : Icon(Symbols.bookmark, color: bookmark.color.toHue(context.colors).medium);
    }(),
    study => Icon(Symbols.school),
    studyPanel => Icon(Symbols.add_notes),
    search => Icon(Symbols.search),
    resources => Icon(Symbols.local_library),
    plans => Icon(Symbols.calendar_month),
    more => Icon(Symbols.other_admission),
  };

  bool get isNavigation => [study, search, resources, plans, more].contains(this);

  Future<void> onPressed(
    BuildContext context, {
    required ChapterReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required Function(StudyPanel) onAddStudyPanel,
    required Function(String bookmarkId) onBookmarkAdded,
  }) async {
    final user = ref.read(userProvider);
    switch (this) {
      case audio:
        ref.updateUser((user) => user.copyWith.audio(isOpen: true));
        await ref
            .read(audioBibleControllerProvider.notifier)
            .toggle(context: .bible, passage: reference.toVerseSelection());
      case bookmark:
        final bookmarkId = user.currentBookmarkId;
        final bookmark = user.currentBookmark;
        if (bookmarkId == null || bookmark == null) {
          final newBookmark = await BookmarkSheet.show(context, reference: reference);
          if (newBookmark != null) {
            final bookmarkId = Uuid().v4();
            ref.updateUser((user) => user.withNewBookmark(bookmarkId, newBookmark));
            onBookmarkAdded(bookmarkId);
          }
        } else {
          await context.showStyledSheet(
            (context, _) => StyledSheet(
              title: t.bookmarks.manage.toText(),
              children: [
                StyledListItem(
                  title: t.bookmarks.stopFollowing.toText(),
                  subtitle: t.bookmarks.stopFollowingDescription.toText(),
                  leading: Symbols.keep_off.toIcon(),
                  onPressed: () {
                    context.pop();
                    ref.updateUser((user) => user.copyWith(currentBookmarkId: null));
                  },
                ),
                StyledListItem(
                  title: t.bookmarks.edit.toText(),
                  leading: Symbols.edit.toIcon(),
                  onPressed: () async {
                    context.pop();
                    final newBookmark = await BookmarkSheet.show(
                      context,
                      reference: reference,
                      initialBookmark: bookmark,
                    );
                    if (newBookmark != null) {
                      ref.updateUser((user) => user.withEditedBookmark(bookmarkId: bookmarkId, bookmark: newBookmark));
                    }
                  },
                ),
                StyledListItem(
                  title: t.bookmarks.delete.toText(),
                  leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                  onPressed: () async {
                    context.pop();
                    final confirmed = await context.showStyledDialog(
                      (context) => StyledDialog.confirmDelete(
                        cancelLabel: t.common.nevermind.toText(),
                        title: t.bookmarks.delete.toText(),
                        body: t.bookmarks.deleteConfirmation.toText(),
                      ),
                    );
                    if (confirmed == true) {
                      ref.updateUser((user) => user.withRemovedBookmark(bookmarkId));
                    }
                  },
                ),
              ],
            ),
          );
        }
      case study:
        context.showStyledSheet(
          (_, _) => StyledSheet(
            title: t.labels.study.toText(),
            subtitle: reference.format().toText(),
            children: [
              StyledList(
                children: [studyPanel, search, resources]
                    .map(
                      (action) => StyledListItem.navigation(
                        title: action.title().toText(),
                        subtitle: action.description().toText(),
                        leading: action.buildIcon(context),
                        onPressed: () async {
                          context.pop();
                          await action.onPressed(
                            context,
                            reference: reference,
                            onNavigateToVerseSelection: onNavigateToVerseSelection,
                            onAddStudyPanel: onAddStudyPanel,
                            onBookmarkAdded: onBookmarkAdded,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
              StyledSection(
                title: t.studyActions.quickStudy.toText(),
                padding: .only(top: 24),
                children: StudyAction.values
                    .map(
                      (action) => StyledListItem.navigation(
                        title: action.title().toText(),
                        subtitle: action.description(regionFormat: reference.format(), regionType: .chapter).toText(),
                        leading: action.icon.toIcon(),
                        onPressed: () {
                          context.pop();
                          action.onPressed(
                            context,
                            regionFormat: reference.format(),
                            verseSelection: reference.toVerseSelection(),
                            onNavigateToVerseSelection: onNavigateToVerseSelection,
                            onAddStudyPanel: onAddStudyPanel,
                            user: ref.read(userProvider),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      case studyPanel:
        final studyPanelType = await context.showStyledSheet<StudyPanelType>(
          (context, _) => StyledSheet(
            title: t.studyPanels.title.toText(),
            children: StudyPanelType.values
                .map(
                  (studyAction) => StyledListItem(
                    title: studyAction.title().toText(),
                    subtitle: studyAction.description().toText(),
                    leading: studyAction.icon.toIcon(),
                    onPressed: () => context.pop(studyAction),
                  ),
                )
                .toList(),
          ),
        );
        if (studyPanelType != null && context.mounted) {
          switch (studyPanelType) {
            case .compare:
              final translation = await context.showStyledSheet(
                (context, _) => StyledSelectionSheet(
                  title: t.studyActions.compare.toText(),
                  options: user.biblesOrDefault,
                  optionMapper: (option) =>
                      StyledSelectOption(title: option.title().toText(), subtitle: option.fullName().toText()),
                ),
              );
              if (translation != null) {
                onAddStudyPanel(StudyPanel.compare(translation: translation));
              }
            case .interlinear:
              final direction = await context.showStyledSheet(
                (context, _) => StyledSelectionSheet(
                  title: t.interlinearUi.direction.toText(),
                  options: InterlinearDirection.values,
                  optionMapper: (option) => StyledSelectOption(
                    title: option.title().toText(),
                    subtitle: option.description().toText(),
                    leading: option.icon.toIcon(),
                  ),
                ),
              );
              if (direction != null) {
                onAddStudyPanel(StudyPanel.interlinear(direction: direction));
              }
            case .commentary:
              final commentaryType = await context.showStyledSheet(
                (context, _) => StyledSelectionSheet(
                  title: t.labels.commentary.toText(),
                  options: user.commentariesOrDefault,
                  optionMapper: (option) =>
                      StyledSelectOption(title: option.title().toText(), subtitle: option.description().toText()),
                ),
              );
              if (commentaryType != null) {
                onAddStudyPanel(StudyPanel.commentary(type: commentaryType));
              }
            case .crossReferences:
              onAddStudyPanel(StudyPanel.crossReferences());
            case .notes:
              onAddStudyPanel(StudyPanel.notes());
          }
        }
      case search:
        final result = await context.push<SearchPageResult>(SearchPage(currentChapterReference: reference));
        if (result != null) {
          onNavigateToVerseSelection(result.selection);
        }
      case resources:
        final resource = await context.showStyledSheet<_Resource>(
          (context, _) => StyledSheet(
            title: t.labels.resources.toText(),
            children: [
              StyledListItem.navigation(
                title: t.labels.dictionary.toText(),
                subtitle: t.toolbarShortcuts.dictionaryDescription.toText(),
                leading: Symbols.menu_book.toIcon(),
                onPressed: () => context.pop(_Resource.dictionary),
              ),
              StyledListItem.navigation(
                title: t.labels.lexicon.toText(),
                subtitle: t.toolbarShortcuts.lexiconDescription.toText(),
                leading: Symbols.translate.toIcon(),
                onPressed: () => context.pop(_Resource.lexicon),
              ),
            ],
          ),
        );
        if (resource == null || !context.mounted) {
          return;
        }
        final page = switch (resource) {
          _Resource.dictionary => DictionaryPage(),
          _Resource.lexicon => LexiconPage(),
        };
        final result = await context.push<VerseSelection>(page);
        if (result != null) {
          onNavigateToVerseSelection(result);
        }
      case plans:
        if (user.planProgressByType.isEmpty) {
          final newPlan = await context.push<BiblePlanType>(BiblePlanSearchPage());
          if (newPlan == null || !context.mounted) {
            return;
          }
        }

        final result = await context.push<VerseSelection>(BiblePlansPage());
        if (result != null) {
          onNavigateToVerseSelection(result);
        }
      case more:
        final result = await context.push<VerseSelection>(MorePage());
        if (result != null) {
          onNavigateToVerseSelection(result);
        }
    }
  }
}

enum _Resource { dictionary, lexicon }
