import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/main_toolbar_configuration.dart';
import 'package:bible/models/user/text_selection_configuration.dart';
import 'package:bible/models/user/verse_selection_configuration.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/text_selection_bottom_bar.dart';
import 'package:bible/ui/widgets/verse_selection_bottom_bar.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readerTypeState = useState<ReaderType?>(null);
    final readerType = readerTypeState.value ?? .reader;

    final selectedTranslationsState = useState(BibleTranslation.defaultTranslations);
    final selectedTranslations = selectedTranslationsState.value.sortedByIndexIn(BibleTranslation.values);

    return StyledModulePage(
      title: 'Get Started'.toText(),
      steps: [
        StyledModuleStep.selection(
          title: 'How do you read the Bible?'.toText(),
          options: ReaderType.values,
          selectedOption: readerTypeState.value,
          onSelectOption: (type) => readerTypeState.value = type,
          optionMapper: (type) => StyledSelectOption(
            title: type.title().toText(),
            subtitle: type.description().toText(),
            leading: type.icon.toIcon(),
          ),
          canGoNext: readerTypeState.value != null,
        ),
        StyledModuleStep(
          title: 'Which translations do you want?'.toText(),
          subtitle: 'You can always change these settings later.'.toText(),
          bodyPadding: .zero,
          childrenBuilder: (context) => BibleTranslation.values
              .groupListsBy((translation) => translation.language)
              .mapToIterable(
                (language, translations) => StyledSection.child(
                  title: language.title().toText(),
                  padding: .only(top: 24),
                  child: Column(
                    spacing: 12,
                    children: translations.map((translation) {
                      final isEnabled = selectedTranslations.length > 1 || !selectedTranslations.contains(translation);
                      return StyledTile(
                        isSelected: selectedTranslations.contains(translation),
                        child: BibleTile(
                          translation: translation,
                          trailing: StyledCheckbox(
                            isSelected: selectedTranslations.contains(translation),
                            isEnabled: isEnabled,
                          ),
                          isEnabled: isEnabled,
                          onPressedOverride: () =>
                              selectedTranslationsState.value = selectedTranslations.withToggle(translation),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
              .toList(),
        ),
        StyledModuleStep(
          title: 'Your ${readerType.title()} Toolbar Setup'.toText(),
          subtitle: '${readerType.setupDescription()} Tweak these in the settings.'.toText(),
          bodyPadding: .zero,
          childrenBuilder: (context) => [
            StyledSection(
              title: 'Main Toolbar'.toText(),
              subtitle: 'Shown when nothing is selected.'.toText(),
              padding: .only(top: 16),
              children: [
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: MainToolbar(
                    colorBuilder: .surfaceTertiary,
                    mainToolbar: readerType.getMainToolbarConfiguration(),
                    chapterReference: ChapterReference(book: .genesis, chapterNum: 1),
                    translation: selectedTranslations.first,
                  ),
                ),
                gapH8,
                ...readerType.getMainToolbarConfiguration().pinnedShortcuts.map(
                  (shortcut) => StyledListItem(
                    title: shortcut.title().toText(),
                    subtitle: shortcut.description().toText(),
                    leading: shortcut.buildIcon(context),
                  ),
                ),
              ],
            ),
            StyledSection(
              title: 'Verse Selection Toolbar'.toText(),
              subtitle: 'Shown when you tap a verse.'.toText(),
              children: [
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: VerseSelectionBottomBar(
                    color: context.colors.surfaceTertiary,
                    verseSelection: VerseSelection.reference(Reference(book: .genesis, chapterNum: 1, verseNum: 1)),
                    configuration: readerType.getVerseSelectionConfiguration(),
                  ),
                ),
                gapH8,
                ...readerType.getVerseSelectionConfiguration().pinnedShortcuts.map(
                  (shortcut) => StyledListItem(
                    title: shortcut.title().toText(),
                    subtitle: shortcut.description().toText(),
                    leading: shortcut.buildIcon(context),
                  ),
                ),
              ],
            ),
            StyledSection(
              title: 'Text Selection Toolbar'.toText(),
              subtitle: 'Shown when you long-press on a word.'.toText(),
              children: [
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: TextSelectionBottomBar(
                    textSelection: null,
                    color: context.colors.surfaceTertiary,
                    configuration: readerType.getTextSelectionConfiguration(),
                  ),
                ),
                gapH8,
                ...readerType.getTextSelectionConfiguration().pinnedShortcuts.map(
                  (shortcut) => StyledListItem(
                    title: shortcut.title().toText(),
                    subtitle: shortcut.description().toText(),
                    leading: shortcut.buildIcon(context),
                  ),
                ),
              ],
            ),
          ],
          buttons: .custom(
            buttonsBuilder: (context, goNext) => [
              StyledRectButton.primary(
                label: 'Start Reading'.toText(),
                onPressed: () async {
                  ref.updateUser(
                    (user) => user.copyWith(
                      translation: selectedTranslations.first,
                      bibles: selectedTranslations,
                      mainToolbar: readerType.getMainToolbarConfiguration(),
                      verseSelection: readerType.getVerseSelectionConfiguration(),
                      textSelection: readerType.getTextSelectionConfiguration(),
                    ),
                  );
                  context.go(BiblePage());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum ReaderType {
  reader,
  noteTaker,
  studier;

  String title() => switch (this) {
    reader => 'Reader',
    noteTaker => 'Note Taker',
    studier => 'Studier',
  };

  String description() => switch (this) {
    reader => 'I read passages and chapters straight through.',
    noteTaker => 'I highlight verses and write down what stands out.',
    studier => 'I dig into commentary, cross-references, and context.',
  };

  String setupDescription() => switch (this) {
    reader => 'Your toolbars are tuned for distraction-free reading and quick navigation.',
    noteTaker => 'Your toolbars are tuned for highlighting and annotating.',
    studier => 'Your toolbars are tuned for cross-references, commentary, and deep study.',
  };

  IconData get icon => switch (this) {
    reader => Symbols.book_ribbon,
    noteTaker => Symbols.note_stack,
    studier => Symbols.school,
  };

  MainToolbarConfiguration getMainToolbarConfiguration() => MainToolbarConfiguration();

  VerseSelectionConfiguration getVerseSelectionConfiguration() => switch (this) {
    reader => VerseSelectionConfiguration(pinnedShortcut1: .annotate, pinnedShortcut2: .study, pinnedShortcut3: .copy),
    noteTaker => VerseSelectionConfiguration(
      pinnedShortcut1: .annotate,
      pinnedShortcut2: .highlight,
      pinnedShortcut3: .copy,
    ),
    studier => VerseSelectionConfiguration(
      pinnedShortcut1: .crossReferences,
      pinnedShortcut2: .commentary,
      pinnedShortcut3: .interlinear,
    ),
  };

  TextSelectionConfiguration getTextSelectionConfiguration() => switch (this) {
    reader => TextSelectionConfiguration(pinnedShortcut1: .annotate, pinnedShortcut2: .search, pinnedShortcut3: .copy),
    noteTaker => TextSelectionConfiguration(
      pinnedShortcut1: .annotate,
      pinnedShortcut2: .highlight,
      pinnedShortcut3: .copy,
    ),
    studier => TextSelectionConfiguration(
      pinnedShortcut1: .annotate,
      pinnedShortcut2: .search,
      pinnedShortcut3: .interlinear,
    ),
  };
}
