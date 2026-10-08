import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:style/style.dart';

class ContentsSection {
  final String title;
  final GlobalKey key;
  final bool isNested;

  ContentsSection({required this.title, required this.key, this.isNested = false});
}

class ContentsSheet {
  static bool hasContents(List<ContentsSection> sections) => sections.length >= 2;

  static Future<void> show(
    BuildContext context, {
    required List<ContentsSection> sections,
    double topPadding = 0,
  }) async {
    final currentSection = getCurrentSection(sections, topPadding: topPadding);
    final section = await context.showStyledSheet<ContentsSection>((context, ref) {
      final listController = useListController();
      usePostFrameEffect(() {
        if (currentSection == null) return;
        listController.jumpToItem(
          index: sections.indexOf(currentSection),
          scrollController: ModalScrollController.of(context)!,
          alignment: 0.5,
        );
      });

      return StyledSheet(
        title: t.labels.contents.toText(),
        listController: listController,
        children: sections
            .map(
              (section) => StyledListItem(
                title: section.title.toText(),
                leading: section.isNested ? SizedBox.shrink() : null,
                leadingWidth: 32,
                trailing: section == currentSection ? Symbols.location_on.toIcon() : null,
                onPressed: () => context.pop(section),
              ),
            )
            .toList(),
      );
    });
    await section?.key.jumpToTop(padding: topPadding);
  }

  static ContentsSection? getCurrentSection(List<ContentsSection> sections, {double topPadding = 0}) =>
      sections.lastWhereOrNull((section) => section.key.hasReachedTop(padding: topPadding));
}
