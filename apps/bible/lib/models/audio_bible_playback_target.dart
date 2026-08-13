import 'package:equatable/equatable.dart';
import 'package:lux/lux.dart';

enum AudioBiblePlaybackContext { bible, readingPlan }

class AudioBiblePlaybackTarget extends Equatable {
  final BibleTranslation translation;
  final VerseSelection passage;
  final AudioBiblePlaybackContext context;

  AudioBiblePlaybackTarget({required this.translation, required this.passage, required this.context}) {
    if (passage.isEmpty || passage.references.map((reference) => reference.toChapterReference()).distinct.length != 1) {
      throw ArgumentError.value(passage, 'passage', 'Audio playback must target one nonempty chapter passage');
    }
  }

  AudioBiblePlaybackTarget.chapter({required this.translation, required ChapterReference chapterReference})
    : passage = chapterReference.toVerseSelection(),
      context = .bible;

  ChapterReference get chapterReference => passage.references.first.toChapterReference();

  Reference get firstReference => passage.references.first;
  Reference get lastReference => passage.references.last;

  Uri? get uri => translation.getAudioAssetUri(chapterReference);

  @override
  List<Object> get props => [translation, passage, context];
}
