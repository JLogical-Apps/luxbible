import 'package:bible/models/study_panel.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class StudyPanelCarousel {
  final PageController pageController;
  final List<StudyPanel> studyPanels;
  final Widget Function(bool showDragHandle, bool isVisible)? leadingPanelBuilder;
  final Widget Function(bool showDragHandle)? trailingPanelBuilder;

  StudyPanelCarousel({
    required this.pageController,
    required this.studyPanels,
    required this.leadingPanelBuilder,
    required this.trailingPanelBuilder,
  });

  int get leadingOffset => leadingPanelBuilder == null ? 0 : 1;
  int get panelCount => leadingOffset + studyPanels.length + (trailingPanelBuilder == null ? 0 : 1);
  bool get hasPanels => panelCount > 0;

  void animateToStudyPanel(StudyPanel studyPanel) => pageController.animateToPage(
    studyPanels.indexOf(studyPanel) + leadingOffset,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
  );

  void addStudyPanel(StudyPanel studyPanel) => studyPanels.has(studyPanel)
      ? animateToStudyPanel(studyPanel)
      : ref.updateUser((user) => user.withStudyPanel(studyPanel));

  void swapStudyPanel(StudyPanel studyPanel, int index) => studyPanels.has(studyPanel)
      ? animateToStudyPanel(studyPanel)
      : ref.updateUser((user) => user.withStudyPanelAt(studyPanel, index));

  void removeStudyPanelAt(int index) =>
      ref.updateUser((user) => user.copyWith(studyPanels: user.studyPanels.withRemovedAt(index)));
}

StudyPanelCarousel useStudyPanelCarousel({
  required WidgetRef ref,
  required bool isSideLayout,
  Widget Function(bool showDragHandle, bool isVisible)? leadingPanelBuilder,
  Widget Function(bool showDragHandle)? trailingPanelBuilder,
}) {
  final user = ref.watch(userProvider);
  final studyPanels = user.studyPanels;
  final hasLeadingPanel = leadingPanelBuilder != null;
  final hasTrailingPanel = trailingPanelBuilder != null;

  final pageController = usePageController(
    initialPage: hasLeadingPanel
        ? 0
        : hasTrailingPanel
        ? studyPanels.length
        : studyPanels.isEmpty
        ? 0
        : (user.studyPanelIndex ?? (studyPanels.length - 1)),
    keys: [studyPanels.join(','), hasLeadingPanel, hasTrailingPanel, isSideLayout],
  );

  return StudyPanelCarousel(
    pageController: pageController,
    studyPanels: studyPanels,
    leadingPanelBuilder: leadingPanelBuilder,
    trailingPanelBuilder: trailingPanelBuilder,
  );
}
