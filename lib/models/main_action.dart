import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:bible/ui/pages/dictionary_page.dart';
import 'package:bible/ui/pages/lexicon_page.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/pages/settings_page.dart';
import 'package:bible/ui/sheets/bookmark_sheet.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/duration_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MainAction {
  audio,
  bookmark,
  study,
  studyPanel,
  search,
  resources,
  plans,
  settings;

  String title() => switch (this) {
    audio => ref.read(isAudioBiblePlayingProvider) ? 'Pause Audio Bible' : 'Play Audio Bible',
    bookmark => 'Bookmark',
    study => 'Study',
    studyPanel => 'Add Study Panel',
    search => 'Search',
    resources => 'Resources',
    plans => 'Bible Plans',
    settings => 'Settings',
  };

  String description({User? user}) => switch (this) {
    audio => 'Listen to the current chapter with an audio-enabled Bible.',
    bookmark =>
      user?.currentBookmark == null
          ? 'Bookmark this chapter to easily access it from the search page.'
          : 'Manage this bookmark.',
    study => 'View study tools for this chapter.',
    studyPanel => 'Pin a panel beside the text that follows along and shows study tools for whatever you\'re reading.',
    search => 'Search for words across the Bible.',
    resources => 'Look up words in the dictionary and lexicon.',
    plans => 'Read through the Bible with guided reading plans.',
    settings => 'View the settings for Lux.',
  };

  Widget buildIcon(BuildContext context, {User? user}) => switch (this) {
    audio => Consumer(
      builder: (context, ref, child) {
        final audioBible = ref.watch(audioBibleProvider).value;
        return Stack(
          clipBehavior: .none,
          children: [
            Icon(ref.watch(isAudioBiblePlayingProvider) ? Symbols.pause : Symbols.play_arrow),
            if (audioBible != null && user?.isAudioOpen == true)
              if (audioBible.duration case final duration? when duration != .zero)
                Positioned(
                  left: -4,
                  right: -4,
                  top: -4,
                  bottom: -4,
                  child: CircularProgressIndicator(value: audioBible.position / duration, strokeWidth: 2),
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
    settings => Icon(Symbols.settings),
  };

  bool get isNavigation => [study, search, resources, plans, settings].contains(this);

  Future<void> onPressed(
    BuildContext context, {
    required ChapterReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required Function(StudyPanel) onAddStudyPanel,
  }) async {
    final user = ref.read(userProvider);
    switch (this) {
      case audio:
        ref.updateUser((user) => user.copyWith(isAudioOpen: true));
        await ref.read(audioBibleProvider.notifier).toggle();
      case bookmark:
        final bookmarkId = user.currentBookmarkId;
        final bookmark = user.currentBookmark;
        if (bookmarkId == null || bookmark == null) {
          final newBookmark = await BookmarkSheet.show(context, reference: reference);
          if (newBookmark != null) {
            ref.updateUser((user) => user.withNewBookmark(newBookmark));
          }
        } else {
          await context.showStyledSheet(
            (context) => StyledSheet(
              title: 'Manage Bookmark'.toText(),
              children: [
                StyledListItem(
                  title: 'Stop Following'.toText(),
                  subtitle: 'Stop this bookmark from following you.'.toText(),
                  leading: Symbols.keep_off.toIcon(),
                  onPressed: () {
                    context.pop();
                    ref.updateUser((user) => user.copyWith(currentBookmarkId: null));
                  },
                ),
                StyledListItem(
                  title: 'Edit Bookmark'.toText(),
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
                  title: 'Delete Bookmark'.toText(),
                  leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                  onPressed: () async {
                    context.pop();
                    final confirmed = await context.showStyledDialog(
                      (context) => StyledDialog.confirmDelete(
                        title: 'Delete Bookmark'.toText(),
                        body: 'Are you sure you want to delete this bookmark?'.toText(),
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
        StudySheet.show(
          context,
          verseSelection: reference.toVerseSelection(),
          regionFormat: reference.format(),
          regionType: RegionType.chapter,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        );
      case studyPanel:
        final studyPanelType = await context.showStyledSheet<StudyPanelType>(
          (context) => StyledSheet(
            title: 'Study Panel'.toText(),
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
                (context) => StyledSelectionSheet(
                  title: 'Compare With'.toText(),
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
                (context) => StyledSelectionSheet(
                  title: 'Interlinear Direction'.toText(),
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
                (context) => StyledSelectionSheet(
                  title: 'Commentary'.toText(),
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
          onNavigateToVerseSelection(VerseSelection.reference(result.reference));
        }
      case resources:
        final resource = await context.showStyledSheet<_Resource>(
          (context) => StyledSheet(
            title: 'Resources'.toText(),
            children: [
              StyledListItem.navigation(
                title: 'Dictionary'.toText(),
                subtitle: "Look up people, places, and topics in Easton's Bible Dictionary.".toText(),
                leading: Symbols.menu_book.toIcon(),
                onPressed: () => context.pop(_Resource.dictionary),
              ),
              StyledListItem.navigation(
                title: 'Lexicon'.toText(),
                subtitle: "Study the original Hebrew and Greek words with Strong's Lexicon.".toText(),
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
      case settings:
        final result = await context.push<VerseSelection>(SettingsPage());
        if (result != null) {
          onNavigateToVerseSelection(result);
        }
    }
  }
}

enum _Resource { dictionary, lexicon }
