import 'dart:math';

import 'package:bible/models/study_panel.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/hooks/study_panel_carousel.dart';
import 'package:bible/ui/pages/resource_order_settings_page.dart';
import 'package:bible/ui/sheets/commentary_selection_sheet.dart';
import 'package:bible/ui/sheets/compare_bible_sheet.dart';
import 'package:bible/ui/sheets/interlinear_direction_sheet.dart';
import 'package:bible/ui/widgets/linked_commentary_study_panel.dart';
import 'package:bible/ui/widgets/linked_study_panel.dart';
import 'package:bible/ui/widgets/visible_verse_utils.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:style/style.dart';

class StudyPanelLayout extends StatelessWidget {
  final StudyPanelCarousel carousel;
  final bool isSideLayout;

  final VerseSelection passage;
  final PassageController? passageController;
  final PassageSelectionController selectionController;
  final double Function() getViewportTop;
  final Function(Reference) onScrollMainToReference;
  final Function(VerseSelection) onNavigateToVerseSelection;

  final Widget child;

  const StudyPanelLayout({
    super.key,
    required this.carousel,
    required this.isSideLayout,
    required this.passage,
    required this.passageController,
    required this.selectionController,
    required this.getViewportTop,
    required this.onScrollMainToReference,
    required this.onNavigateToVerseSelection,
    required this.child,
  });

  static bool isSideLayoutFor(BuildContext context) =>
      MediaQuery.sizeOf(context).width - MediaQuery.viewPaddingOf(context).horizontal >= 700;

  @override
  Widget build(BuildContext context) {
    final section = MediaQuery.removeViewPadding(
      context: context,
      removeLeft: true,
      removeRight: true,
      child: StudyPanelSection(
        carousel: carousel,
        isSideLayout: isSideLayout,
        passage: passage,
        passageController: passageController,
        selectionController: selectionController,
        getViewportTop: getViewportTop,
        onScrollMainToReference: onScrollMainToReference,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ),
    );

    return isSideLayout
        ? Row(
            children: [
              Expanded(flex: 4, child: child),
              if (carousel.hasPanels) ...[
                Expanded(flex: 3, child: section),
                SizedBox(width: MediaQuery.viewPaddingOf(context).right),
              ],
            ],
          )
        : Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(child: child),
                    if (carousel.panelCount > 1)
                      Positioned(bottom: 2, left: 0, right: 0, child: StudyPanelIndicator(carousel: carousel)),
                  ],
                ),
              ),
              section,
            ],
          );
  }
}

class StudyPanelSection extends HookConsumerWidget {
  final StudyPanelCarousel carousel;
  final bool isSideLayout;

  final VerseSelection passage;
  final PassageController? passageController;
  final PassageSelectionController selectionController;
  final double Function() getViewportTop;
  final Function(Reference) onScrollMainToReference;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const StudyPanelSection({
    super.key,
    required this.carousel,
    required this.isSideLayout,
    required this.passage,
    required this.passageController,
    required this.selectionController,
    required this.getViewportTop,
    required this.onScrollMainToReference,
    required this.onNavigateToVerseSelection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final readerConfiguration = ref.watch(luxReaderConfigurationProvider);

    final studyPanels = carousel.studyPanels;
    final chapterReference = passage.references.first.toChapterReference();

    final minStudyPanelHeight = 82.0;
    final maxStudyPanelHeight = max(minStudyPanelHeight, MediaQuery.sizeOf(context).height * 0.75);

    final studyPanelHeightRef = useRef(
      (maxStudyPanelHeight * user.studyPanelBottomPosition).clamp(minStudyPanelHeight, maxStudyPanelHeight),
    );

    final isResizingState = useState(false);

    final visibleVerseSelectionState = useState(VerseSelection.empty());
    final visibleVerseSelection = selectionController.verseSelection ?? visibleVerseSelectionState.value;

    final chapterValue = ref.watch(
      chapterProvider(chapterReference: chapterReference, translation: user.getTranslationFor(chapterReference.book)),
    );

    useOnPostFrameListenableChange(passageController?.scrollController, () {
      final studyPanelHeight = studyPanelHeightRef.value.clamp(minStudyPanelHeight, maxStudyPanelHeight);

      final visibleReferences = getVisibleReferencesInViewport(
        keyByReference: passageController?.keyByReference ?? {},
        viewportTop: getViewportTop(),
        viewportBottom: isSideLayout
            ? MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).bottom
            : MediaQuery.sizeOf(context).height - studyPanelHeight,
      );

      visibleVerseSelectionState.value = VerseSelection.fromReferences(visibleReferences);
    }, [chapterValue.value, isResizingState.value, MediaQuery.sizeOf(context)]);

    usePeriodic(Duration(seconds: 1), () {
      if (isSideLayout) {
        return;
      }

      final studyPanelPercentVisible = studyPanelHeightRef.value / maxStudyPanelHeight;
      if (studyPanelPercentVisible != user.studyPanelBottomPosition) {
        ref.updateUser((user) => user.copyWith(studyPanelBottomPosition: studyPanelPercentVisible));
      }
    });

    final pageController = carousel.pageController;
    final currentCarouselPage = useListenableSelector(
      pageController,
      () => pageController.pageOrNull?.round() ?? pageController.initialPage,
    );

    Widget panelPadding(Widget child, {Key? key}) =>
        Padding(key: key, padding: isSideLayout ? .symmetric(horizontal: 4) : .zero, child: child);

    Widget studyPanelView(int i, StudyPanel studyPanel) => switch (studyPanel) {
      CompareStudyPanel(:final translation) => HookBuilder(
        key: ValueKey((passage, translation)),
        builder: (context) {
          final paragraphsState = useState<List<Paragraph>?>(null);
          final controller = usePassageController(chapterReference);

          return LinkedStudyPanel(
            chapterReference: chapterReference,
            passageTopReference: visibleVerseSelection.references.firstOrNull,
            scrollController: controller.scrollController,
            showDragHandle: !isSideLayout,
            subtitle: t.studyPanels.compareWith(translation: translation.title()).toText(),
            trailing: Tooltip(
              message: t.studyPanels.swapBible,
              child: StyledCircleButton.md(
                child: Symbols.book.toIcon(),
                onPressed: () async {
                  final newBible = await CompareBibleSheet.show(context, initialBible: translation);
                  if (newBible != null) {
                    carousel.swapStudyPanel(studyPanel.copyWith(translation: newBible), i);
                  }
                },
              ),
            ),
            onClose: () => carousel.removeStudyPanelAt(i),
            onScrollMainToReference: onScrollMainToReference,
            onScrollPanelToReference: (reference, panelHeight) {
              final sizeMultiplier = readerConfiguration.paragraphsConfiguration(context, translation).sizeMultiplier;
              final sectionHeight =
                  paragraphsState.value?.getSectionTypeForVerse(reference.verseNum)?.getHeight(sizeMultiplier) ?? 0;
              controller.scrollToReference(
                reference,
                paragraphs: paragraphsState.value ?? [],
                alignment: sectionHeight / panelHeight,
              );
            },
            getTopVisibleReference: (viewportTop, viewportBottom) => getVisibleReferencesInViewport(
              keyByReference: controller.keyByReference,
              viewportTop: viewportTop,
              viewportBottom: viewportBottom,
            ).firstOrNull,
            isActive: currentCarouselPage == i + carousel.leadingOffset,
            isContentLoaded: paragraphsState.value != null,
            child: PassageBuilder(
              verseSelection: passage,
              translation: translation,
              controller: controller,
              padding: .all(16),
              onParagraphsLoaded: (paragraphs) => paragraphsState.value = paragraphs,
            ),
          );
        },
      ),
      CommentaryStudyPanel(:final type) => LinkedCommentaryStudyPanel(
        key: ValueKey((i, chapterReference, type)),
        type: type,
        chapterReference: chapterReference,
        passageTopReference: visibleVerseSelection.references.firstOrNull,
        onScrollMainToReference: onScrollMainToReference,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        onClose: () => carousel.removeStudyPanelAt(i),
        trailing: Tooltip(
          message: t.studyPanels.swapCommentary,
          child: StyledCircleButton.md(
            child: Symbols.tooltip_2.toIcon(),
            onPressed: () async {
              final newCommentary = await CommentarySelectionSheet.show(context, initialCommentary: type);
              if (newCommentary != null) {
                carousel.swapStudyPanel(studyPanel.copyWith(type: newCommentary), i);
              }
            },
          ),
        ),
        isActive: currentCarouselPage == i + carousel.leadingOffset,
        showDragHandle: !isSideLayout,
      ),
      _ => StyledSheet.builder(
        key: ValueKey((i, visibleVerseSelection)),
        showDragHandle: !isSideLayout,
        title: visibleVerseSelection.format().toText(),
        subtitle: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              studyPanel.title().toText(),
              if (studyPanel.studyAction?.getTranslationOverride(user: user) case final override?)
                StyledTag.sm(child: override.title().toText()),
            ],
          ),
        ),
        leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => carousel.removeStudyPanelAt(i)),
        trailing: switch (studyPanel) {
          InterlinearStudyPanel(:final direction) => Tooltip(
            message: t.studyPanels.swapDirection,
            child: StyledCircleButton.md(
              child: Symbols.swap_horiz.toIcon(),
              onPressed: () async {
                final newDirection = await InterlinearDirectionSheet.show(context, initialDirection: direction);
                if (newDirection != null) {
                  carousel.swapStudyPanel(studyPanel.copyWith(direction: newDirection), i);
                }
              },
            ),
          ),
          LinkedResourcesStudyPanel() => Tooltip(
            message: t.studyActions.editLinkedResources,
            child: StyledCircleButton.md(
              child: Symbols.tune.toIcon(),
              onPressed: () => context.push(ResourceOrderSettingsPage()),
            ),
          ),
          _ => null,
        },
        childrenBuilder: (context, ref) => studyPanel.buildSheetChildren(
          context,
          ref,
          verseSelection: visibleVerseSelection,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          user: user,
        ),
      ),
    };

    final carouselView = SwipePageView(
      controller: pageController,
      pageCount: carousel.panelCount,
      onPageChanged: (page) {
        final studyPanelIndex = page - carousel.leadingOffset;
        if (studyPanelIndex >= 0 && studyPanelIndex < studyPanels.length) {
          ref.updateUser((user) => user.copyWith(studyPanelIndex: studyPanelIndex));
          ref.markOnboardingStep(.addStudyPanel);
        }
      },
      children: [
        if (carousel.leadingPanelBuilder case final builder?)
          panelPadding(builder(!isSideLayout, currentCarouselPage == 0)),
        ...studyPanels.mapIndexed(
          (i, studyPanel) => panelPadding(studyPanelView(i, studyPanel), key: ValueKey((i, studyPanel))),
        ),
        if (carousel.trailingPanelBuilder case final builder?) panelPadding(builder(!isSideLayout)),
      ].map((child) => KeepAliveContainer(child: child)).toList(),
    );

    if (isSideLayout) {
      if (!carousel.hasPanels) {
        return SizedBox.shrink();
      }

      return Padding(
        padding: .only(
          top: MediaQuery.paddingOf(context).top + 8,
          bottom: MediaQuery.paddingOf(context).bottom + 8,
          left: 4,
          right: 4,
        ),
        child: Stack(
          children: [
            carouselView,
            if (carousel.panelCount > 1)
              Positioned(bottom: 2, left: 0, right: 0, child: StudyPanelIndicator(carousel: carousel)),
          ],
        ),
      );
    }

    return AnimatedGrow(
      duration: isResizingState.value ? Duration(milliseconds: 1) : Duration(milliseconds: 300),
      child: carousel.hasPanels
          ? ResizableContainer(
              initialHeight: studyPanelHeightRef.value,
              minHeight: minStudyPanelHeight,
              maxHeight: maxStudyPanelHeight,
              onResizeStart: () => isResizingState.value = true,
              onResizeEnd: () => isResizingState.value = false,
              onHeightUpdated: (size) => studyPanelHeightRef.value = size,
              child: Container(width: double.infinity, color: context.colors.surfacePrimary, child: carouselView),
            )
          : SizedBox.shrink(key: ValueKey('empty')),
    );
  }
}

class StudyPanelIndicator extends StatelessWidget {
  final StudyPanelCarousel carousel;

  const StudyPanelIndicator({super.key, required this.carousel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: .all(4),
        decoration: BoxDecoration(
          borderRadius: .circular(999),
          color: context.colors.surfaceSecondary.withValues(alpha: 0.5),
        ),
        child: SmoothPageIndicator(
          key: ValueKey(carousel.panelCount),
          controller: carousel.pageController,
          count: carousel.panelCount,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: context.colors.contentPrimary,
            dotColor: context.colors.surfacePrimary,
          ),
        ),
      ),
    );
  }
}
