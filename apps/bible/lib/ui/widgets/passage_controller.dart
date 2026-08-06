import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:utils_core/utils_core.dart';

class PassageController {
  final ScrollController scrollController;
  final ListController listController;
  final Map<Reference, GlobalKey> keyByReference;
  final Map<Reference, GlobalKey> keyBySectionReference;

  PassageController({required ChapterReference chapterReference})
    : scrollController = ScrollController(),
      listController = ListController(),
      keyByReference = chapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
      keyBySectionReference = chapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey()));

  void dispose() {
    scrollController.dispose();
    listController.dispose();
  }

  Future<void> scrollToReference(
    Reference reference, {
    required List<Paragraph> paragraphs,
    double alignment = 0,
    Duration duration = const Duration(milliseconds: 200),
  }) async {
    final sectionKey = paragraphs.getSectionIndexForVerse(reference.verseNum) == null
        ? null
        : keyBySectionReference[reference];
    final key = sectionKey?.currentContext == null ? keyByReference[reference] : sectionKey;
    if (key?.currentContext?.mounted == true) {
      await key?.scrollIntoView(axis: .vertical, duration: duration, alignment: alignment);
      return;
    }

    final paragraphIndex =
        paragraphs.getSectionIndexForVerse(reference.verseNum) ?? paragraphs.getIndexForVerse(reference.verseNum);
    if (paragraphIndex == null || !listController.isAttached || !scrollController.hasClients) {
      return;
    }

    if (duration == .zero) {
      listController.jumpToItem(index: paragraphIndex, scrollController: scrollController, alignment: alignment);
    } else {
      listController.animateToItem(
        index: paragraphIndex,
        scrollController: scrollController,
        alignment: alignment,
        duration: (_) => duration,
        curve: (_) => Curves.easeInOutCubic,
      );
    }
  }

  void jumpToReference(Reference reference, {required List<Paragraph> paragraphs, double alignment = 0}) =>
      scrollToReference(reference, paragraphs: paragraphs, alignment: alignment, duration: .zero);
}

PassageController usePassageController(ChapterReference chapterReference) => useDisposable(
  useMemoized(() => PassageController(chapterReference: chapterReference), [chapterReference]),
  (controller) => controller.dispose(),
);
