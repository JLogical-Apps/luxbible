import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/user/passage_configuration.dart';
import 'package:bible/models/user/selection_configuration.dart';
import 'package:bible/models/user/toolbar_configuration.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/widgets/passage_bottom_bar.dart';
import 'package:bible/ui/widgets/selection_bottom_bar.dart';
import 'package:bible/ui/widgets/toolbar.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readerTypeState = useState<ReaderType?>(null);
    final readerType = readerTypeState.value ?? .reader;
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
                  child: Toolbar(
                    colorBuilder: .surfaceTertiary,
                    toolbar: readerType.getToolbarConfiguration(),
                    chapterReference: ChapterReference(book: .genesis, chapterNum: 1),
                    translation: .bsb,
                  ),
                ),
                gapH8,
                ...readerType.getToolbarConfiguration().pinnedShortcuts.map(
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
                  child: PassageBottomBar(
                    color: context.colors.surfaceTertiary,
                    passage: Passage.reference(Reference(book: .genesis, chapterNum: 1, verseNum: 1)),
                    configuration: readerType.getPassageConfiguration(),
                  ),
                ),
                gapH8,
                ...readerType.getPassageConfiguration().pinnedShortcuts.map(
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
                  child: SelectionBottomBar(
                    selection: null,
                    color: context.colors.surfaceTertiary,
                    configuration: readerType.getSelectionConfiguration(),
                  ),
                ),
                gapH8,
                ...readerType.getSelectionConfiguration().pinnedShortcuts.map(
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
                      toolbar: readerType.getToolbarConfiguration(),
                      passage: readerType.getPassageConfiguration(),
                      selection: readerType.getSelectionConfiguration(),
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

  ToolbarConfiguration getToolbarConfiguration() => ToolbarConfiguration();

  PassageConfiguration getPassageConfiguration() => switch (this) {
    reader => PassageConfiguration(pinnedShortcut1: .annotate, pinnedShortcut2: .study, pinnedShortcut3: .copy),
    noteTaker => PassageConfiguration(pinnedShortcut1: .annotate, pinnedShortcut2: .highlight, pinnedShortcut3: .copy),
    studier => PassageConfiguration(
      pinnedShortcut1: .crossReferences,
      pinnedShortcut2: .commentary,
      pinnedShortcut3: .interlinear,
    ),
  };

  SelectionConfiguration getSelectionConfiguration() => switch (this) {
    reader ||
    studier => SelectionConfiguration(pinnedShortcut1: .annotate, pinnedShortcut2: .search, pinnedShortcut3: .copy),
    noteTaker => SelectionConfiguration(
      pinnedShortcut1: .annotate,
      pinnedShortcut2: .highlight,
      pinnedShortcut3: .copy,
    ),
  };
}
