import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/hooks/audio_bible_passage_sync.dart';
import 'package:bible/ui/widgets/audio_bible_panel.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanReadPage extends HookConsumerWidget {
  final BiblePlanType planType;
  final int dayIndex;
  final int initialPassageIndex;

  const BiblePlanReadPage({
    super.key,
    required this.planType,
    required this.dayIndex,
    required this.initialPassageIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(biblePlansProvider);
    final plan = plans[planType];
    if (plan == null) {
      return SizedBox.shrink();
    }

    final day = plan.days[dayIndex];
    final passages = day.passages;

    final user = ref.watch(userProvider);
    final progress = user.getHydratedPlanProgress(planType: planType, planByType: plans);
    final currentProgress = progress?.progress.days[dayIndex] ?? BiblePlanDayProgress.incomplete();

    final selection = usePassageSelection(ref.watch(luxReaderConfigurationProvider).selection);

    final planAudio = ref.watch(audioBibleProvider(context: .plan));
    final planAudioPlayer = ref.watch(audioBiblePlayerProvider(context: .plan));
    final audioBibleController = ref.read(audioBibleControllerProvider.notifier);

    void navigateToVerseSelection(VerseSelection verseSelection) => context.pop(verseSelection);

    final tabController = useTabController(
      initialLength: passages.isEmpty ? 1 : passages.length,
      initialIndex: initialPassageIndex.clamp(0, passages.isEmpty ? 0 : passages.length - 1),
    );
    final currentIndex = useListenableSelector(tabController, () => tabController.index);
    final nextIncompletePassageIndex = user.getNextIncompletePlanPassageIndex(
      planType: planType,
      dayIndex: dayIndex,
      day: day,
      currentIndex: currentIndex,
    );

    final passageControllerRegistry = useRegistry<VerseSelection, PassageController>();

    void playPassage(int passageIndex) async {
      final passage = passages[passageIndex];
      final translation = user.getTranslationFor(passage.references.first.book);
      if (!translation.hasAudioBible) {
        audioBibleController.remove(context: .plan);

        final shouldContinue = await context.showStyledDialog(
          (_) => StyledDialog(
            title: t.audio.unavailable.toText(),
            body: t.audio.switchRequired.toText(),
            buttonsBuilder: (buttonContext) => [
              StyledRectButton.secondary(
                label: t.common.switchTo(translation: user.audioTranslation.title()).toText(),
                onPressed: () {
                  buttonContext.pop(true);
                  ref.updateUser((user) => user.withTranslation(user.audioTranslation));
                },
              ),
              StyledRectButton.primary(label: t.common.ok.toText(), onPressed: () => buttonContext.pop(false)),
            ],
          ),
        );

        if (shouldContinue != true) {
          return;
        }
      }

      selection.clear();
      audioBibleController.play(context: .plan, passage: passage);
    }

    final audioBibleSync = useAudioBiblePassageSync(
      ref: ref,
      context: .plan,
      audioBible: planAudio,
      selection: selection,
      passageControllers: passageControllerRegistry,
      getPassageControllerKey: (passage) => passage,
      onPassageChanged: (passage) {
        final passageIndex = passages.indexOfOrNull(passage);
        if (passageIndex != null && passageIndex != tabController.index) {
          tabController.animateTo(passageIndex);
        }
      },
      onCompleteAndNext: (completedPassage) {
        final newUser = ref.updateUser(
          (user) =>
              user.withPassageCompleted(planType: planType, dayIndex: dayIndex, day: day, passage: completedPassage),
        );

        final completedPassageIndex = passages.indexOfOrNull(completedPassage);
        final nextIndex = completedPassageIndex == null
            ? null
            : newUser.getNextIncompletePlanPassageIndex(
                planType: planType,
                dayIndex: dayIndex,
                day: day,
                currentIndex: completedPassageIndex,
              );

        return nextIndex == null ? null : passages[nextIndex];
      },
      removeOnDispose: true,
    );

    useValueChanged<int, void>(currentIndex, (oldIndex, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        selection.clear();
        final session = ref.read(audioBibleProvider(context: .plan));
        if (session != null && session.passage != passages[currentIndex]) {
          await audioBibleController.pause(context: .plan);
          await audioBibleController.replacePassage(context: .plan, passage: passages[currentIndex]);
        }
        ref.updateUser(
          (user) =>
              user.withPassageCompleted(planType: planType, dayIndex: dayIndex, day: day, passage: passages[oldIndex]),
        );
      });
    });

    return StyledPage(
      title: t.biblePlans.day(day: dayIndex + 1).toText(),
      trailing: StyledCircleButton.md(
        child: Icon(planAudio == null ? Symbols.play_arrow : Symbols.stop),
        onPressed: planAudio == null
            ? () => playPassage(currentIndex)
            : () => audioBibleController.remove(context: .plan),
      ),
      body: StyledDock(
        forceHeight: true,
        activeScrollKey: 'passage',
        children: [
          StyledTabBar.scrollable(
            tabController: tabController,
            tabTitles: passages.map((passage) {
              final isCompleted = currentProgress.isPassageComplete(passage);
              return Row(
                spacing: 8,
                children: [
                  passage.format().toText(),
                  Icon(
                    isCompleted ? Symbols.check_circle : Symbols.circle,
                    fill: isCompleted ? 1 : 0,
                    color: isCompleted ? context.colors.contentPrimary : context.colors.contentSecondary,
                    size: 16,
                  ),
                ],
              );
            }).toList(),
          ),
          Expanded(
            child: SwipeTabView(
              controller: tabController,
              children: passages
                  .map(
                    (passage) => HookBuilder(
                      builder: (context) {
                        final chapterReference = passage.references.first.toChapterReference();
                        final passageController = usePassageController(chapterReference);
                        useRegistryItem(passageControllerRegistry, passage, passageController);

                        return SafeArea(
                          top: false,
                          bottom: false,
                          child: PassageBuilder(
                            verseSelection: passage,
                            selection: selection,
                            emphasizedReference: audioBibleSync.getEmphasizedReferenceForPassage(passage),
                            controller: passageController,
                            onNavigateToVerseSelection: navigateToVerseSelection,
                            onReferencePressed: audioBibleSync.onReferencePressed,
                            padding: .symmetric(horizontal: 24, vertical: 16),
                            contentBuilder: (context, passageContent) => KeyedScrollTransformer(
                              scrollKey: 'passage',
                              child: NotificationListener<ScrollStartNotification>(
                                onNotification: (notification) {
                                  if (notification.dragDetails != null && planAudioPlayer.isPlaying) {
                                    audioBibleController.pause(context: .plan);
                                  }
                                  return false;
                                },
                                child: passageContent,
                              ),
                            ),
                            footer: StyledRectButton.secondary(
                              label: (passage.isChapter ? t.biblePlans.readInContext : t.biblePlans.readEntireChapter)
                                  .toText(),
                              onPressed: () => PassagePreviewPage.show(
                                context,
                                verseSelection: passage,
                                onNavigateToVerseSelection: (selection) => context.pop(selection),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
        aboveButtons: selection.hasSelection || planAudio != null
            ? Column(
                mainAxisAlignment: .end,
                children: [
                  if (selection.hasSelection)
                    SelectionToolbar(selection: selection, onNavigateToVerseSelection: navigateToVerseSelection),
                  if (planAudio != null)
                    AudioBiblePanelBody(context: .plan, padding: EdgeInsets.symmetric(horizontal: 16) + .only(top: 16)),
                ],
              )
            : null,
        buttonsBuilder: (context) => [
          if (planAudio == null)
            StyledRectButton.primary(
              label: (nextIncompletePassageIndex == null ? t.common.done : t.common.next).toText(),
              onPressed: () {
                ref.updateUser(
                  (user) => user.withPassageCompleted(
                    planType: planType,
                    dayIndex: dayIndex,
                    day: day,
                    passage: passages[currentIndex],
                  ),
                );
                if (nextIncompletePassageIndex != null) {
                  tabController.animateTo(nextIncompletePassageIndex);
                } else {
                  context.pop();
                }
              },
            ),
        ],
      ),
    );
  }
}
