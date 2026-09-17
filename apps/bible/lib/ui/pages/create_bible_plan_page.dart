import 'package:bible/functions/bible_plan_generator.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/custom_bible_plans_provider.dart';
import 'package:bible/services/bible_plan_file_service.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils_core/utils_core.dart';

const biblePlanFileExtension = '.lxbp';
final biblePlanFormatUri = Uri.parse('https://www.luxbible.app/resources/lxbp');

class CreateBiblePlanPage extends HookConsumerWidget implements StyledRoute<String> {
  const CreateBiblePlanPage({super.key});

  @override
  String get path => '/bible-plans/create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodState = useState<BiblePlanCreationMethod?>(null);
    final method = methodState.value;

    final importedPlanState = useState<BiblePlan?>(null);
    final importedPlan = importedPlanState.value;
    final importErrorState = useState<String?>(null);

    // AI
    final descriptionState = useDependentState(() => '', [method]);
    final description = descriptionState.value;
    final hasCopiedPromptState = useDependentState(() => false, [method, description]);

    // Book & Duration
    final selectedBooksState = useDependentState<Set<BookType>>(() => {}, [method]);
    final selectedBooks = selectedBooksState.value;
    final selectedBooksKey = BookType.values.where(selectedBooks.contains).map((book) => book.name).join(',');

    final durationState = useDependentState(() => getDefaultBiblePlanDuration(selectedBooks), [
      method,
      selectedBooksKey,
    ]);
    final duration = durationState.value;

    final booksFilterState = useDependentState(() => '', [method]);
    final scrollController = useUnfocusOnScrollDown(useScrollController());

    final generatedDaysState = useState<List<BiblePlanDay>?>(null);

    // Shared
    final biblePlans = ref.watch(biblePlansProvider);
    final existingNames = biblePlans.mapToIterable((id, plan) => plan.getDisplayName(id)).distinct;

    final nameState = useDependentState(() {
      final baseName =
          importedPlan?.name ??
          (method == .booksAndDuration && selectedBooks.isNotEmpty
              ? getGeneratedPlanName(selectedBooks: selectedBooks, duration: duration)
              : t.biblePlans.myBiblePlan);
      if (!existingNames.contains(baseName)) return baseName;

      return Iterable.generate(
        existingNames.length + 1,
        (index) => '$baseName (${index + 2})',
      ).firstWhere((name) => !existingNames.contains(name));
    }, [method, importedPlan, selectedBooksKey, duration]);

    final name = nameState.value;
    final nameError = name.trim().isEmpty
        ? t.biblePlans.nameRequired
        : existingNames.contains(name)
        ? t.biblePlans.nameAlreadyExists
        : null;

    final colorState = useDependentState(() => importedPlan?.color ?? BiblePlanColor.values.random, [
      method,
      importedPlan,
    ]);

    final daysState = useDependentState(() => importedPlan?.days ?? generatedDaysState.value ?? [BiblePlanDay()], [
      method,
      importedPlan,
      generatedDaysState.value,
    ]);
    final days = daysState.value;

    final plan = BiblePlan(name: name, colorOverride: colorState.value, days: daysState.value);

    final stepIndexState = useState(0);

    final reviewStepIndex = switch (method) {
      .ai || .booksAndDuration => 4,
      .importFile => 3,
      _ => 2,
    };

    void importPlanContents(String contents) {
      try {
        importedPlanState.value = BiblePlanFileService.decode(contents);
        importErrorState.value = null;
      } on BiblePlanFileException catch (exception) {
        importedPlanState.value = null;
        importErrorState.value = exception.error.message();
      } catch (_) {
        importedPlanState.value = null;
        importErrorState.value = t.biblePlans.importErrors.readFailed;
      }
    }

    Future<void> importPlanFile() async {
      try {
        final file = await openFile(
          acceptedTypeGroups: [
            XTypeGroup(
              label: t.biblePlans.biblePlanFile,
              extensions: ['lxbp'],
              mimeTypes: [BiblePlanFileService.mimeType, 'application/json', 'application/octet-stream'],
              uniformTypeIdentifiers: ['app.luxbible.bible-plan'],
            ),
          ],
        );
        if (file == null) return;

        importPlanContents(await file.readAsString());
      } catch (_) {
        importedPlanState.value = null;
        importErrorState.value = t.biblePlans.importErrors.readFailed;
      }
    }

    return StyledModulePage(
      title: (stepIndexState.value == reviewStepIndex ? t.biblePlans.review : t.biblePlans.createCustomPlan).toText(),
      onStepChanged: (stepIndex) => stepIndexState.value = stepIndex,
      scrollController: scrollController,
      steps: [
        StyledModuleStep.selection(
          title: t.biblePlans.creationMethodQuestion.toText(),
          options: BiblePlanCreationMethod.values,
          selectedOption: method,
          optionMapper: (method) => StyledSelectOption(
            title: method.title().toText(),
            subtitle: method.description().toText(),
            leading: method.icon.toIcon(),
          ),
          onSelectOption: (method) => methodState.value = method,
          canGoNext: method != null,
        ),
        if (method == .importFile)
          StyledModuleStep(
            title: t.biblePlans.importPlan.toText(),
            subtitle: t.biblePlans.importInstructions.toText(),
            childrenBuilder: (context) => [
              BiblePlanImportContent(
                plan: importedPlan,
                error: importErrorState.value,
                description: StyledRichText(
                  parts: [
                    StyledRichTextPart.text(t.biblePlans.importOptionsHintPrefix),
                    StyledRichTextPart.link(biblePlanFileExtension, onTap: () => launchUrl(biblePlanFormatUri)),
                    StyledRichTextPart.text(t.biblePlans.importOptionsHintSuffix),
                  ],
                ),
                onImport: () => showBiblePlanImportOptions(
                  context,
                  onImportFile: importPlanFile,
                  onImportContents: importPlanContents,
                ),
              ),
            ],
            buttons: .next(canGoNext: importedPlan != null && importErrorState.value == null),
          ),
        if (method == .ai)
          StyledModuleStep(
            title: t.biblePlans.describeYourPlan.toText(),
            childrenBuilder: (context) => [
              StyledTextField.multiline(
                text: description,
                label: Row(
                  spacing: 8,
                  children: [
                    Expanded(child: t.biblePlans.planDescription.toText()),
                    StyledLink(
                      t.biblePlans.examples,
                      onPressed: () =>
                          showBiblePlanAiExamples(context, onSelected: (example) => descriptionState.value = example),
                    ),
                  ],
                ),
                error: description.isNotEmpty && description.trim().isEmpty
                    ? t.biblePlans.descriptionRequired.toText()
                    : null,
                hintText: t.biblePlans.describeYourPlanHint,
                onChanged: (description) => descriptionState.value = description,
              ),
            ],
            buttons: .next(canGoNext: description.trim().isNotEmpty),
          ),
        if (method == .ai)
          StyledModuleStep(
            title: t.biblePlans.aiImportTitle.toText(),
            subtitle: t.biblePlans.aiImportInstructions.toText(),
            childrenBuilder: (context) => [
              StyledRectButton.secondary(
                label: t.biblePlans.copyPrompt.toText(),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: getBiblePlanAiPrompt(description)));
                  hasCopiedPromptState.value = true;
                  if (context.mounted) context.showStyledSnackbar(message: t.biblePlans.promptCopied.toText());
                },
              ),
              gapH32,
              BiblePlanImportContent(
                plan: importedPlan,
                error: importErrorState.value,
                description: StyledRichText(
                  parts: [
                    StyledRichTextPart.text(t.biblePlans.aiImportOptionsHintPrefix),
                    StyledRichTextPart.link(biblePlanFileExtension, onTap: () => launchUrl(biblePlanFormatUri)),
                    StyledRichTextPart.text(t.biblePlans.aiImportOptionsHintSuffix),
                  ],
                ),
                onImport: hasCopiedPromptState.value
                    ? () => showBiblePlanImportOptions(
                        context,
                        onImportFile: importPlanFile,
                        onImportContents: importPlanContents,
                      )
                    : null,
              ),
            ],
            buttons: .next(canGoNext: importedPlan != null && importErrorState.value == null),
          ),
        if (method == .booksAndDuration)
          StyledModuleStep(
            title: t.biblePlans.chooseBooks.toText(),
            bodyPadding: .zero,
            childrenBuilder: (context) => [
              BookSelectionSections(
                selectedBooks: selectedBooks,
                onChanged: (books) => selectedBooksState.value = books,
                includeWholeBible: true,
                search: booksFilterState.value,
              ),
            ],
            aboveButtons: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: StyledTextField(
                    text: booksFilterState.value,
                    hintText: t.biblePlans.filterBooks,
                    autocorrect: false,
                    onChanged: (filter) => booksFilterState.value = filter,
                  ),
                ),
                BookSelectionSummary(
                  selectedBooks: selectedBooks,
                  onChanged: (books) => selectedBooksState.value = books,
                ),
              ],
            ),
            buttons: .next(canGoNext: selectedBooks.isNotEmpty),
          ),
        if (method == .booksAndDuration)
          StyledModuleStep(
            title: t.biblePlans.durationInstructions.toText(),
            forceFillHeight: true,
            childrenBuilder: (context) => [
              Expanded(
                child: Center(
                  child: StyledDial(
                    key: ValueKey(selectedBooksKey),
                    options: Range.generate(1, 365).toList(),
                    initiallySelected: duration,
                    onSelected: (duration) => durationState.value = duration,
                    itemBuilder: (duration) =>
                        Text(t.biblePlans.durationDayCount(count: duration), style: context.textStyle.headingSm),
                  ),
                ),
              ),
            ],
            buttons: .next(
              onGoNext: () async {
                final localBible = await ref.read(localBibleProvider(translation: .bsb).future);
                return generatedDaysState.value = BiblePlanGenerator().generate(
                  bible: localBible,
                  selectedBooks: selectedBooks,
                  duration: duration,
                );
              },
            ),
          ),
        StyledModuleStep(
          title: t.biblePlans.nameAndColor.toText(),
          childrenBuilder: (context) => [
            StyledTextField(
              text: name,
              label: t.labels.name.toText(),
              error: nameError?.toText(),
              onChanged: (name) => nameState.value = name,
            ),
            gapH24,
            Wrap(
              alignment: .center,
              spacing: 12,
              runSpacing: 12,
              children: BiblePlanColor.values
                  .map(
                    (color) => StyledTile(
                      isSelected: colorState.value == color,
                      onPressed: () => colorState.value = color,
                      child: BiblePlanThumbnail(displayName: name, color: color, size: .lg),
                    ),
                  )
                  .toList(),
            ),
          ],
          buttons: .next(canGoNext: nameError == null),
        ),
        StyledModuleStep(
          bodyPadding: .zero,
          onBackPressed: (goBack) async {
            final shouldDiscard = await context.showStyledDialog(
              (context) => StyledDialog.confirmDelete(
                title: t.biblePlans.discardPlanQuestion.toText(),
                body: t.biblePlans.discardPlanConfirmation.toText(),
                deleteLabel: t.biblePlans.discard.toText(),
                cancelLabel: t.common.nevermind.toText(),
              ),
            );
            if (shouldDiscard == true && context.mounted) goBack();
          },
          childrenBuilder: (context) => [
            ...StyledDivider(height: 2).wrapPositioned(
              days
                  .mapIndexed(
                    (dayIndex, day) => StyledSwipeable(
                      key: ValueKey((day, days.length)),
                      actions: [
                        .remove(
                          onPressed: () async {
                            final shouldRemove = day.isReviewAndReflect
                                ? true
                                : await context.showStyledDialog(
                                    (context) => StyledDialog.confirmDelete(
                                      title: t.biblePlans.removeDayQuestion.toText(),
                                      body: t.biblePlans.removeDayConfirmation(day: dayIndex + 1).toText(),
                                      deleteLabel: t.common.remove.toText(),
                                      cancelLabel: t.common.nevermind.toText(),
                                    ),
                                  );
                            if (shouldRemove == true) daysState.value = days.withRemovedAt(dayIndex);
                          },
                        ),
                      ],
                      child: StyledStickyHeader(
                        title: t.biblePlans.day(day: dayIndex + 1).toText(),
                        headerPadding: .symmetric(horizontal: 16, vertical: 8),
                        trailing: Row(
                          children: [
                            StyledCircleButton.md(
                              child: Symbols.add.toIcon(),
                              colorBuilder: .surfaceSecondary,
                              onPressed: () async {
                                final passage = await FindInBibleSheet.show(
                                  context,
                                  selectionConfiguration: ref.watch(luxReaderConfigurationProvider).selection,
                                  title: t.biblePlans.addPassage.toText(),
                                );
                                if (passage != null) daysState.value = days.withPassageAdded(dayIndex, passage);
                              },
                            ),
                          ],
                        ),
                        children: [
                          if (day.isReviewAndReflect)
                            Padding(
                              padding: EdgeInsets.all(16).copyWith(top: 0),
                              child: StyledTile.message(
                                leading: Symbols.book_ribbon.toIcon(),
                                title: t.biblePlans.reviewAndReflect.toText(),
                              ),
                            )
                          else
                            StyledReorderableList(
                              shrinkWrap: true,
                              onReorder: (oldIndex, newIndex) =>
                                  daysState.value = days.withPassageReordered(dayIndex, oldIndex, newIndex),
                              children: day.passages.map((passage) {
                                return StyledSwipeable(
                                  key: ValueKey(passage),
                                  actions: [
                                    .remove(
                                      onPressed: () => daysState.value = days.withPassageRemoved(dayIndex, passage),
                                    ),
                                  ],
                                  child: StyledListItem(
                                    size: .sm,
                                    title: passage.format().toText(),
                                    onPressed: () => PassagePreviewPage.show(context, verseSelection: passage),
                                    trailing: StyledCircleButton.md(
                                      child: Symbols.more_vert.toIcon(),
                                      onPressed: () => context.showStyledSheet(
                                        (sheetContext, _) => StyledSheet(
                                          title: passage.format().toText(),
                                          children: [
                                            if (days.length >= 2)
                                              StyledListItem.navigation(
                                                leading: Symbols.move_group.toIcon(),
                                                title: t.biblePlans.moveToAnotherDay.toText(),
                                                onPressed: () {
                                                  sheetContext.pop();
                                                  context.showStyledSheet(
                                                    (sheetContext, _) => StyledSheet(
                                                      title: t.biblePlans.moveToAnotherDay.toText(),
                                                      children: days.indexed
                                                          .where((entry) => entry.$1 != dayIndex)
                                                          .map(
                                                            (entry) => StyledListItem(
                                                              title: t.biblePlans.day(day: entry.$1 + 1).toText(),
                                                              subtitle: entry.$2.isReviewAndReflect
                                                                  ? t.biblePlans.reviewAndReflect.toText()
                                                                  : Text(
                                                                      entry.$2.passages
                                                                          .map((passage) => passage.format())
                                                                          .join(' • '),
                                                                    ),
                                                              onPressed: () {
                                                                daysState.value = days.withPassageMoved(
                                                                  sourceDayIndex: dayIndex,
                                                                  destinationDayIndex: entry.$1,
                                                                  passage: passage,
                                                                );
                                                                sheetContext.pop();
                                                              },
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            StyledListItem(
                                              leading: Icon(Symbols.delete, color: sheetContext.colors.contentCritical),
                                              title: t.common.remove.toText(),
                                              onPressed: () {
                                                daysState.value = days.withPassageRemoved(dayIndex, passage);
                                                sheetContext.pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            gapH32,
            Padding(
              padding: .all(16),
              child: StyledRectButton.secondary(
                label: t.biblePlans.addDay.toText(),
                onPressed: days.length < 365 ? () => daysState.value = [...days, BiblePlanDay()] : null,
              ),
            ),
          ],
          buttons: .custom(
            buttonsBuilder: (context, _) => [
              StyledRectButton.primary(
                label: t.biblePlans.createAndStart.toText(),
                onPressed: plan.isValid
                    ? () {
                        final id = ref.read(customBiblePlansProvider.notifier).create(plan);
                        ref.updateUser(
                          (user) =>
                              user.withStartedPlan(planId: id, plan: plan).withOnboardingStepCompleted(.startBiblePlan),
                        );
                        context.pop(id);
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum BiblePlanCreationMethod {
  ai,
  booksAndDuration,
  importFile,
  manual;

  String title() => switch (this) {
    ai => t.biblePlans.createWithAi,
    booksAndDuration => t.biblePlans.chooseBooksAndDuration,
    importFile => t.biblePlans.importAction,
    manual => t.biblePlans.manual,
  };

  String description() => switch (this) {
    ai => t.biblePlans.createWithAiDescription,
    booksAndDuration => t.biblePlans.chooseBooksAndDurationDescription,
    importFile => t.biblePlans.importDescription,
    manual => t.biblePlans.manualDescription,
  };

  IconData get icon => switch (this) {
    ai => Symbols.auto_awesome,
    booksAndDuration => Symbols.menu_book,
    importFile => Symbols.download,
    manual => Symbols.edit_note,
  };
}

class BiblePlanImportContent extends StatelessWidget {
  final BiblePlan? plan;
  final String? error;
  final Widget description;
  final Function()? onImport;

  const BiblePlanImportContent({
    super.key,
    required this.plan,
    required this.error,
    required this.description,
    required this.onImport,
  });

  @override
  Widget build(BuildContext context) => StyledFormInput(
    label: t.biblePlans.importAction.toText(),
    description: description,
    child: Column(
      spacing: 16,
      children: [
        StyledRectButton.secondary(label: t.biblePlans.importAction.toText(), onPressed: onImport),
        if (plan case final plan?)
          Row(
            spacing: 8,
            children: [
              Icon(Symbols.check_circle, color: context.colors.green.primary),
              Expanded(child: Text(plan.name, style: context.textStyle.labelMd)),
            ],
          )
        else if (error case final error?)
          Row(
            spacing: 8,
            children: [
              Icon(Symbols.cancel, color: context.colors.contentCritical),
              Expanded(child: Text(error, style: context.textStyle.labelMd.critical())),
            ],
          ),
      ],
    ),
  );
}

Future<void> showBiblePlanImportOptions(
  BuildContext context, {
  required Function() onImportFile,
  required Function(String) onImportContents,
}) => context.showStyledSheet(
  (sheetContext, _) => StyledSheet(
    title: t.biblePlans.importPlanTitle.toText(),
    children: [
      StyledListItem.navigation(
        leading: Symbols.file_open.toIcon(),
        title: t.biblePlans.importFromFile.toText(),
        subtitle: t.biblePlans.importFromFileDescription.toText(),
        onPressed: () {
          sheetContext.pop();
          onImportFile();
        },
      ),
      StyledListItem.navigation(
        leading: Symbols.content_paste.toIcon(),
        title: t.biblePlans.pasteToImport.toText(),
        subtitle: t.biblePlans.pasteToImportDescription.toText(),
        onPressed: () {
          sheetContext.pop();
          showBiblePlanPasteImportSheet(context, onImportContents: onImportContents);
        },
      ),
    ],
  ),
);

Future<void> showBiblePlanPasteImportSheet(BuildContext context, {required Function(String) onImportContents}) =>
    context.showStyledSheet((sheetContext, _) {
      final contentsState = useState('');
      final contents = contentsState.value;

      return StyledSheet(
        title: t.biblePlans.pastePlan.toText(),
        children: [
          Padding(
            padding: .all(16),
            child: StyledTextField.multiline(
              text: contents,
              label: t.biblePlans.fileContents.toText(),
              hintText: t.biblePlans.fileContentsHint,
              autocorrect: false,
              onChanged: (contents) => contentsState.value = contents,
            ),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: t.biblePlans.importAction.toText(),
            onPressed: contents.trim().isEmpty
                ? null
                : () {
                    onImportContents(contents);
                    sheetContext.pop();
                  },
          ),
        ],
      );
    });

Future<void> showBiblePlanAiExamples(BuildContext context, {required Function(String) onSelected}) =>
    context.showStyledSheet(
      (sheetContext, _) => StyledSheet(
        title: t.biblePlans.aiExamples.toText(),
        children: t.biblePlans.aiExampleList
            .map(
              (example) => StyledListItem(
                title: example.toText(),
                trailing: StyledCircleButton.md(
                  colorBuilder: .surfaceSecondary,
                  child: Symbols.add.toIcon(),
                  onPressed: () {
                    onSelected(example);
                    sheetContext.pop();
                  },
                ),
              ),
            )
            .toList(),
      ),
    );

String getBiblePlanAiPrompt(String description) {
  final osisBookIdentifiers = BookType.values.map((book) => book.osisId()).join(', ');
  final colorValues = BiblePlanColor.values.map((color) => color.name).join(', ');

  return '''Create a Bible reading plan from this request:

$description

Create a downloadable file named with the .lxbp extension. The .lxbp format is documented at:
$biblePlanFormatUri

The file contents must use exactly this Lux BiblePlan structure:

{
  "name": "Romans in 30 Days",
  "days": [
    {"passages": ["Rom.1", "Ps.1"]},
    {"passages": ["Rom.2.1-Rom.2.16"]},
    {"passages": []}
  ],
  "color": "blue"
}

Rules:
- Use only name, days, and the optional color at the top level. Use only passages in each day.
- name must contain non-whitespace text.
- Include 1 through 365 numbered days.
- If the request specifies a duration, create exactly that many day entries. Fill every requested day with a reading unless the request calls for reflection days. Do not shorten the plan by leaving out requested days.
- Include at least one reading across the plan.
- A reflection day is {"passages": []}.
- A reading day can contain one or more passages. Put each separate passage in that day's passages array.
- Break chapters into smaller verse ranges when that helps fill the requested duration, keeps readings manageable, or balances the reading across days.
- passages must contain valid OSIS references. Examples: "Rom.1", "Rom.1.1", "Rom.1.1-Rom.1.17", and "Ps.1.1-Ps.1.6".
- Supported OSIS book identifiers are: $osisBookIdentifiers.
- Every reference and range must exist, remain in canonical order, and place the complete book identifier on both sides of a range.
- Do not put the exact same passage string in one day more than once. Repeating a passage on different days is allowed.
- color is optional. If present, it must be exactly one of: $colorValues.
- Plans use numbered days, not dates. If the request mentions weekdays, treat Day 1 as Monday and every seventh day as Sunday, independent of the actual date the user starts the plan.
- Do not include an ID, version, progress, reminders, Bible text, comments, or any fields outside the structure above.

Provide the completed plan as a downloadable .lxbp file. If you cannot create a downloadable file, return only the raw .lxbp file contents in a code block without an explanation.''';
}

String getGeneratedPlanName({required Set<BookType> selectedBooks, required int duration}) {
  final books = selectedBooks.toList().sortedByIndexIn(BookType.values).toList();
  final booksName = switch (books) {
    _ when books.length == BookType.values.length => t.biblePlans.generatedNames.bible,
    _
        when books.every((book) => book.testament == .oldTestament) &&
            books.length == BookType.values.where((book) => book.testament == .oldTestament).length =>
      t.testaments.old,
    _
        when books.every((book) => book.testament == .newTestament) &&
            books.length == BookType.values.where((book) => book.testament == .newTestament).length =>
      t.testaments.newTestament,
    [final book] => book.title(isPlural: true),
    [final first, final second] => t.biblePlans.generatedNames.twoBooks(
      first: first.title(isPlural: true),
      second: second.title(isPlural: true),
    ),
    _ => t.biblePlans.generatedNames.bookCount(count: books.length),
  };

  return switch (duration) {
    1 => t.biblePlans.generatedNames.inOneDay(books: booksName),
    365 => t.biblePlans.generatedNames.inAYear(books: booksName),
    _ => t.biblePlans.generatedNames.inDays(books: booksName, count: duration),
  };
}

int getDefaultBiblePlanDuration(Set<BookType> selectedBooks) {
  if (selectedBooks.isEmpty) return 30;
  final selectedChapterCount = selectedBooks.map((book) => book.bookInfo.numChapters).sum;
  final bibleChapterCount = BookType.values.map((book) => book.bookInfo.numChapters).sum;
  return (selectedChapterCount * 365 / bibleChapterCount).round().clamp(1, 365);
}

extension BiblePlanFileErrorMessage on BiblePlanFileError {
  String message() => switch (this) {
    .malformedJson => t.biblePlans.importErrors.malformedJson,
    .invalidStructure => t.biblePlans.importErrors.invalidStructure,
    .nameRequired => t.biblePlans.importErrors.nameRequired,
    .invalidDayCount => t.biblePlans.importErrors.invalidDayCount,
    .readingRequired => t.biblePlans.importErrors.readingRequired,
    .invalidPassage => t.biblePlans.importErrors.invalidPassage,
    .duplicatePassage => t.biblePlans.importErrors.duplicatePassage,
  };
}
