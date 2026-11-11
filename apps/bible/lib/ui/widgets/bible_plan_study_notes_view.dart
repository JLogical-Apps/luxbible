import 'package:bible/models/bible_plan_study_note.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BiblePlanStudyNotesView extends HookWidget {
  final BiblePlanStudyNote note;
  final double sizeMultiplier;
  final ScrollController scrollController;
  final Function() onReadToEnd;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const BiblePlanStudyNotesView({
    super.key,
    required this.note,
    required this.sizeMultiplier,
    required this.scrollController,
    required this.onReadToEnd,
    required this.onNavigateToVerseSelection,
  });

  @override
  Widget build(BuildContext context) {
    void checkReadToEnd() {
      if (scrollController.hasClients && scrollController.position.extentAfter == 0) onReadToEnd();
    }

    useOnListenableChange(scrollController, checkReadToEnd);

    // Notes short enough to fit on screen never scroll, so they count as read once they're laid out.
    usePostFrameEffect(checkReadToEnd, []);

    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: .linear(mediaQuery.textScaler.scale(1) * sizeMultiplier)),
      child: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          padding: .only(left: 24, top: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 96),
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 16,
              children: [
                Text(note.title, style: context.textStyle.headingSm),
                RichContentList(content: note.body, onNavigateToVerseSelection: onNavigateToVerseSelection),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
