import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/providers/commentary_provider.dart';
import 'package:bible/ui/widgets/commentary_content.dart';
import 'package:bible/ui/widgets/linked_study_panel.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class LinkedCommentaryStudyPanel extends HookConsumerWidget {
  final CommentaryType type;
  final ChapterReference chapterReference;
  final Reference? passageTopReference;
  final Function(Reference) onScrollMainToReference;
  final Function(VerseSelection) onNavigateToVerseSelection;
  final Function() onClose;
  final Widget? trailing;
  final bool isActive;
  final bool showDragHandle;

  const LinkedCommentaryStudyPanel({
    super.key,
    required this.type,
    required this.chapterReference,
    required this.passageTopReference,
    required this.onScrollMainToReference,
    required this.onNavigateToVerseSelection,
    required this.onClose,
    this.trailing,
    required this.isActive,
    required this.showDragHandle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentaryValue = ref.watch(commentaryProvider(type: type, book: chapterReference.book));
    final commentary = commentaryValue.value;

    final blocks = commentary?.blocksByChapter[chapterReference.chapterNum] ?? [];
    final hasIntroduction = chapterReference.chapterNum == 1 && commentary?.introduction.isNotEmpty == true;
    final syncSelections = [
      if (hasIntroduction) null,
      ...blocks.map(
        (block) => switch (block) {
          CommentaryOutline() => null,
          CommentarySection(:final selection) => selection,
        },
      ),
    ];

    final controller = useCommentaryPanelController(chapterReference, syncSelections);

    final explicitNavigationSequenceRef = useRef(0);
    final extentPrecalculationPolicy = useMemoized(
      () => FixedNumExtentPrecalculationPolicy(numItems: syncSelections.length + 1),
      [syncSelections.length],
    );

    Future<void> scrollToIndex(int index, {Reference? reference}) async {
      final navigationSequence = explicitNavigationSequenceRef.value + 1;
      explicitNavigationSequenceRef.value = navigationSequence;
      final targetReference = reference ?? controller.getAnchorForIndex(index);
      if (targetReference != null) onScrollMainToReference(targetReference);

      await controller.scrollToIndex(index);
      await Future.delayed(Duration(milliseconds: 150));
      if (explicitNavigationSequenceRef.value == navigationSequence) explicitNavigationSequenceRef.value = 0;
    }

    final itemCount = syncSelections.length;
    final introductionOffset = hasIntroduction ? 1 : 0;
    final children = [
      if (hasIntroduction)
        CommentaryIntroductionView(
          book: chapterReference.book,
          content: commentary!.introduction,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          trailing: CommentaryHeaderNavigation(index: 0, itemCount: itemCount, onNavigateToIndex: scrollToIndex),
        ),
      ...blocks.mapIndexed(
        (index, block) => CommentaryBlockView(
          block: block,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          onOutlineSelectionPressed: (selection) {
            final reference = selection.references.first;
            final index = controller.getSectionIndexForReference(reference);
            if (index != null) scrollToIndex(index, reference: reference);
          },
          trailing: CommentaryHeaderNavigation(
            index: index + introductionOffset,
            itemCount: itemCount,
            onNavigateToIndex: scrollToIndex,
          ),
        ),
      ),
    ];

    return LinkedStudyPanel(
      chapterReference: chapterReference,
      passageTopReference: passageTopReference,
      scrollController: controller.scrollController,
      onScrollMainToReference: (reference) {
        if (explicitNavigationSequenceRef.value == 0) onScrollMainToReference(reference);
      },
      onScrollPanelToReference: (reference, panelHeight) => controller.scrollToReference(reference),
      getTopVisibleReference: controller.getTopVisibleReference,
      isActive: isActive,
      isContentLoaded: commentaryValue.hasValue,
      showDragHandle: showDragHandle,
      subtitle: type.title().toText(),
      trailing: trailing,
      onClose: onClose,
      child: commentary == null
          ? Center(child: StyledLoading())
          : children.isEmpty
          ? Padding(
              padding: .all(16),
              child: StyledBanner(message: t.emptyStates.noCommentaries.toText()),
            )
          : StyledScrollbar(
              controller: controller.scrollController,
              child: SuperListView(
                controller: controller.scrollController,
                listController: controller.listController,
                padding: .zero,
                extentPrecalculationPolicy: extentPrecalculationPolicy,
                children: StyledDivider(height: 2).wrapPositioned(
                  children
                      .mapIndexed((index, child) => KeyedSubtree(key: controller.keyByIndex[index], child: child))
                      .toList(),
                ),
              ),
            ),
    );
  }
}

class CommentaryPanelController {
  final ChapterReference chapterReference;
  final List<VerseSelection?> syncSelections;
  final ScrollController scrollController;
  final ListController listController;
  final Map<int, GlobalKey> keyByIndex;

  CommentaryPanelController({required this.chapterReference, required this.syncSelections})
    : scrollController = ScrollController(),
      listController = ListController(),
      keyByIndex = Map.fromEntries(syncSelections.mapIndexed((index, _) => MapEntry(index, GlobalKey())));

  void dispose() {
    scrollController.dispose();
    listController.dispose();
  }

  Reference? getTopVisibleReference(double viewportTop, double viewportBottom) => keyByIndex.entries
      .where((entry) {
        final bounds = entry.value.globalBounds;
        return bounds != null && bounds.bottom >= viewportTop && bounds.top <= viewportBottom;
      })
      .map((entry) => getAnchorForIndex(entry.key))
      .nonNulls
      .firstOrNull;

  Reference? getAnchorForIndex(int index) =>
      syncSelections[index]?.references.firstOrNull ?? chapterReference.getReference(1);

  int? getIndexForReference(Reference reference) {
    if (syncSelections.isEmpty) return null;
    if (reference.verseNum == 1 && syncSelections.first == null) return 0;

    return getSectionIndexForReference(reference) ?? 0;
  }

  int? getSectionIndexForReference(Reference reference) {
    final linkedSelections = syncSelections
        .mapIndexed(
          (index, selection) => switch (selection) {
            final selection? => (index: index, selection: selection),
            null => null,
          },
        )
        .nonNulls
        .toList();

    final precedingSelections = linkedSelections
        .where((entry) => entry.selection.references.first <= reference)
        .sortedBy((entry) => entry.selection.references.first);

    return linkedSelections.firstWhereOrNull((entry) => entry.selection.hasReference(reference))?.index ??
        precedingSelections.lastOrNull?.index ??
        linkedSelections.firstOrNull?.index;
  }

  Future<void> scrollToIndex(int index, {Duration duration = const Duration(milliseconds: 200)}) async {
    final key = keyByIndex[index];
    if (key?.currentContext?.mounted == true) {
      await key?.scrollIntoView(axis: .vertical, duration: duration, alignment: 0);
      return;
    }

    if (!listController.isAttached || !scrollController.hasClients) return;

    listController.animateToItem(
      index: index,
      scrollController: scrollController,
      alignment: 0,
      duration: (_) => duration / 2,
      curve: (_) => Curves.easeInCubic,
    );
    await Future.delayed(duration / 2);
    await WidgetsBinding.instance.endOfFrame;
    await key?.scrollIntoView(axis: .vertical, duration: duration / 2, alignment: 0, curve: Curves.easeOutCubic);
  }

  Future<void> scrollToReference(Reference reference, {Duration duration = const Duration(milliseconds: 200)}) async {
    final index = getIndexForReference(reference);
    if (index == null) return;
    await scrollToIndex(index, duration: duration);
  }
}

class CommentaryHeaderNavigation extends StatelessWidget {
  final int index;
  final int itemCount;
  final Function(int) onNavigateToIndex;

  const CommentaryHeaderNavigation({
    super.key,
    required this.index,
    required this.itemCount,
    required this.onNavigateToIndex,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    spacing: 4,
    children: [
      Visibility(
        visible: index > 0,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Tooltip(
          message: t.commentaryUi.previousSection,
          child: StyledCircleButton.md(
            child: Symbols.arrow_upward.toIcon(),
            onPressed: () => onNavigateToIndex(index - 1),
          ),
        ),
      ),
      Visibility(
        visible: index < itemCount - 1,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Tooltip(
          message: t.commentaryUi.nextSection,
          child: StyledCircleButton.md(
            child: Symbols.arrow_downward.toIcon(),
            onPressed: () => onNavigateToIndex(index + 1),
          ),
        ),
      ),
    ],
  );
}

CommentaryPanelController useCommentaryPanelController(
  ChapterReference chapterReference,
  List<VerseSelection?> syncSelections,
) => useDisposable(
  useMemoized(() => CommentaryPanelController(chapterReference: chapterReference, syncSelections: syncSelections), [
    chapterReference,
    syncSelections.map((selection) => selection?.osisId()).join(','),
  ]),
  (controller) => controller.dispose(),
);
