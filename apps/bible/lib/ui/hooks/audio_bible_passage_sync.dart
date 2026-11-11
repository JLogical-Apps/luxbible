import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class AudioBiblePassageSync {
  final AudioBiblePlayerState player;
  final Reference? spokenReference;

  AudioBiblePassageSync({required this.player, required this.spokenReference});

  Reference? getEmphasizedReferenceForChapter(ChapterReference chapterReference) =>
      player.isPlaying && spokenReference?.toChapterReference() == chapterReference ? spokenReference : null;

  Reference? getEmphasizedReferenceForPassage(ChapterPassage passage) {
    final spokenReference = this.spokenReference;
    return player.isPlaying && spokenReference != null && passage.references.has(spokenReference)
        ? spokenReference
        : null;
  }
}

AudioBiblePassageSync useAudioBiblePassageSync<K>({
  required WidgetRef ref,
  required AudioBibleContext context,
  required AudioBibleContextState? audioBible,
  required PassageSelectionController selection,
  required Registry<K, PassageController> passageControllers,
  required K Function(ChapterPassage) getPassageControllerKey,
  required Function(ChapterPassage) onPassageChanged,
  required ChapterPassage? Function(ChapterPassage completedPassage) onCompleteAndNext,
  bool removeOnDispose = false,
}) {
  final audioBibleController = ref.read(audioBibleControllerProvider.notifier);
  final player = ref.watch(audioBiblePlayerProvider(context: context));
  final spokenReference = ref.watch(audioBibleSpokenReferenceProvider(context: context));

  final passageController = audioBible == null ? null : passageControllers[getPassageControllerKey(audioBible.passage)];

  Future<void> scrollToSpokenReference() async {
    if (audioBible == null || spokenReference == null || passageController == null) {
      return;
    }

    final paragraphs = await ref.read(
      verseSelectionParagraphsProvider(
        selection: audioBible.passage.verseSelection,
        translation: audioBible.translation,
      ).future,
    );

    final currentAudioBible = ref.read(audioBibleProvider(context: context));
    final currentSpokenReference = ref.read(audioBibleSpokenReferenceProvider(context: context));
    final currentPassageController = currentAudioBible == null
        ? null
        : passageControllers[getPassageControllerKey(currentAudioBible.passage)];
    if (currentAudioBible == audioBible &&
        currentSpokenReference == spokenReference &&
        currentPassageController == passageController) {
      passageController.scrollToReference(spokenReference, paragraphs: paragraphs, alignment: 0.2);
    }
  }

  usePostFrameEffect(scrollToSpokenReference, [
    audioBible?.passage,
    audioBible?.translation,
    spokenReference,
    passageController,
  ]);

  // Resuming keeps the same spoken reference, so it needs its own scroll back to where the reader scrolled away from.
  usePostFrameEffect(() {
    if (player.isPlaying) scrollToSpokenReference();
  }, [player.isPlaying]);

  useOnStreamData(audioBibleController.completions(context), (ChapterPassage passage) async {
    final nextPassage = onCompleteAndNext(passage);
    if (nextPassage == null || !await audioBibleController.play(context: context, passage: nextPassage)) {
      audioBibleController.remove(context: context);
    }
  });

  usePostFrameEffect(() {
    if (player.isActive && audioBible != null) onPassageChanged(audioBible.passage);
  }, [audioBible?.passage, player.isActive]);

  usePostFrameEffect(() {
    if (player.isPlaying && selection.hasSelection) selection.clear();
  }, [player.isPlaying]);

  usePostFrameEffect(() {
    if (selection.hasSelection && player.isPlaying) audioBibleController.pause(context: context);
  }, [selection.hasSelection]);

  useOnDispose(() {
    if (removeOnDispose) audioBibleController.remove(context: context);
  });

  return AudioBiblePassageSync(player: player, spokenReference: spokenReference);
}
