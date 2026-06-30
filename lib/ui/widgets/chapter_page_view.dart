import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/hook_consumer_builder.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ChapterPageView extends StatelessWidget {
  final PageController controller;
  final User user;
  final Widget Function(BuildContext context, ChapterReference chapterReference, Chapter chapter) itemBuilder;
  final void Function(ChapterReference chapterReference)? onPageChanged;
  final void Function(ChapterReference chapterReference)? onNavigate;

  const ChapterPageView({
    super.key,
    required this.controller,
    required this.user,
    required this.itemBuilder,
    this.onPageChanged,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        const sensitivity = 8;

        final currentPage = controller.page!.round();
        final newPageIndex = details.delta.dx > sensitivity
            ? currentPage - 1
            : details.delta.dx < -sensitivity
            ? currentPage + 1
            : null;

        if (newPageIndex == null || newPageIndex < 0 || newPageIndex >= ChapterReference.values.length) {
          return;
        }

        final reference = ChapterReference.fromBibleChapterIndex(newPageIndex);
        controller.animateToPage(
          reference.bibleChapterIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
        );
        onNavigate?.call(reference);
      },
      child: PageView.builder(
        controller: controller,
        allowImplicitScrolling: false,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged == null
            ? null
            : (pageIndex) => onPageChanged!(ChapterReference.fromBibleChapterIndex(pageIndex)),
        itemBuilder: (context, pageIndex) => HookConsumerBuilder(
          builder: (context, ref) {
            final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);
            final translation = user.translation.effectiveFor(chapterReference.book);
            final chapterValue = ref.watch(
              chapterProvider(translation: translation, chapterReference: chapterReference),
            );

            if (chapterValue.hasError) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 24) + .symmetric(horizontal: 16),
                child: Column(
                  spacing: 12,
                  children: [
                    StyledTile.message(
                      leading: Symbols.error.toIcon(),
                      title: 'Something went wrong'.toText(),
                      subtitle: 'Make sure you are connected to the internet or try again later.'.toText(),
                    ),
                    if (user.translation != .bsb)
                      StyledRectButton.secondary(
                        label: 'Switch to BSB'.toText(),
                        onPressed: () => ref.updateUser((user) => user.copyWith(translation: .bsb)),
                      ),
                    StyledRectButton.secondary(
                      label: 'Try Again'.toText(),
                      onPressed: () => ref.invalidate(
                        chapterProvider(translation: translation, chapterReference: chapterReference),
                        asReload: true,
                      ),
                    ),
                  ],
                ),
              );
            }

            final chapter = chapterValue.value;
            if (chapter == null) {
              return SizedBox.shrink();
            }

            return itemBuilder(context, chapterReference, chapter);
          },
        ),
      ),
    );
  }
}
