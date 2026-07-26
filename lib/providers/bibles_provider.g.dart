// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bibles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localBible)
final localBibleProvider = LocalBibleFamily._();

final class LocalBibleProvider
    extends $FunctionalProvider<AsyncValue<Bible>, Bible, FutureOr<Bible>>
    with $FutureModifier<Bible>, $FutureProvider<Bible> {
  LocalBibleProvider._({
    required LocalBibleFamily super.from,
    required BibleTranslation super.argument,
  }) : super(
         retry: null,
         name: r'localBibleProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$localBibleHash();

  @override
  String toString() {
    return r'localBibleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Bible> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Bible> create(Ref ref) {
    final argument = this.argument as BibleTranslation;
    return localBible(ref, translation: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalBibleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$localBibleHash() => r'f4ee81d6d88803abe9aa50e2ff78e9bab1ffc892';

final class LocalBibleFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Bible>, BibleTranslation> {
  LocalBibleFamily._()
    : super(
        retry: null,
        name: r'localBibleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  LocalBibleProvider call({required BibleTranslation translation}) =>
      LocalBibleProvider._(argument: translation, from: this);

  @override
  String toString() => r'localBibleProvider';
}

@ProviderFor(studyBible)
final studyBibleProvider = StudyBibleProvider._();

final class StudyBibleProvider
    extends $FunctionalProvider<AsyncValue<Bible>, Bible, FutureOr<Bible>>
    with $FutureModifier<Bible>, $FutureProvider<Bible> {
  StudyBibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyBibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyBibleHash();

  @$internal
  @override
  $FutureProviderElement<Bible> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Bible> create(Ref ref) {
    return studyBible(ref);
  }
}

String _$studyBibleHash() => r'38488664834ff466439fb919c22a900bde2538ec';

@ProviderFor(chapter)
final chapterProvider = ChapterFamily._();

final class ChapterProvider
    extends $FunctionalProvider<AsyncValue<Chapter>, Chapter, FutureOr<Chapter>>
    with $FutureModifier<Chapter>, $FutureProvider<Chapter> {
  ChapterProvider._({
    required ChapterFamily super.from,
    required ({ChapterReference chapterReference, BibleTranslation translation})
    super.argument,
  }) : super(
         retry: RiverpodUtils.noRetry,
         name: r'chapterProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chapterHash();

  @override
  String toString() {
    return r'chapterProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Chapter> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Chapter> create(Ref ref) {
    final argument =
        this.argument
            as ({
              ChapterReference chapterReference,
              BibleTranslation translation,
            });
    return chapter(
      ref,
      chapterReference: argument.chapterReference,
      translation: argument.translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chapterHash() => r'2231b1ddca1da80bfdae53e9ea3d7e8e78783897';

final class ChapterFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Chapter>,
          ({ChapterReference chapterReference, BibleTranslation translation})
        > {
  ChapterFamily._()
    : super(
        retry: RiverpodUtils.noRetry,
        name: r'chapterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ChapterProvider call({
    required ChapterReference chapterReference,
    required BibleTranslation translation,
  }) => ChapterProvider._(
    argument: (chapterReference: chapterReference, translation: translation),
    from: this,
  );

  @override
  String toString() => r'chapterProvider';
}

@ProviderFor(verse)
final verseProvider = VerseFamily._();

final class VerseProvider
    extends $FunctionalProvider<AsyncValue<Verse?>, Verse?, FutureOr<Verse?>>
    with $FutureModifier<Verse?>, $FutureProvider<Verse?> {
  VerseProvider._({
    required VerseFamily super.from,
    required ({Reference reference, BibleTranslation translation})
    super.argument,
  }) : super(
         retry: null,
         name: r'verseProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$verseHash();

  @override
  String toString() {
    return r'verseProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Verse?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Verse?> create(Ref ref) {
    final argument =
        this.argument as ({Reference reference, BibleTranslation translation});
    return verse(
      ref,
      reference: argument.reference,
      translation: argument.translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VerseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$verseHash() => r'62a672b86ae9979cf573111e53db36902f2ed22c';

final class VerseFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Verse?>,
          ({Reference reference, BibleTranslation translation})
        > {
  VerseFamily._()
    : super(
        retry: null,
        name: r'verseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  VerseProvider call({
    required Reference reference,
    required BibleTranslation translation,
  }) => VerseProvider._(
    argument: (reference: reference, translation: translation),
    from: this,
  );

  @override
  String toString() => r'verseProvider';
}

@ProviderFor(verseSelectionVerses)
final verseSelectionVersesProvider = VerseSelectionVersesFamily._();

final class VerseSelectionVersesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Verse>>,
          List<Verse>,
          FutureOr<List<Verse>>
        >
    with $FutureModifier<List<Verse>>, $FutureProvider<List<Verse>> {
  VerseSelectionVersesProvider._({
    required VerseSelectionVersesFamily super.from,
    required ({VerseSelection selection, BibleTranslation translation})
    super.argument,
  }) : super(
         retry: null,
         name: r'verseSelectionVersesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$verseSelectionVersesHash();

  @override
  String toString() {
    return r'verseSelectionVersesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Verse>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Verse>> create(Ref ref) {
    final argument =
        this.argument
            as ({VerseSelection selection, BibleTranslation translation});
    return verseSelectionVerses(
      ref,
      selection: argument.selection,
      translation: argument.translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VerseSelectionVersesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$verseSelectionVersesHash() =>
    r'84a76410248b909a13c3acbb6bab1bbf4815478a';

final class VerseSelectionVersesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Verse>>,
          ({VerseSelection selection, BibleTranslation translation})
        > {
  VerseSelectionVersesFamily._()
    : super(
        retry: null,
        name: r'verseSelectionVersesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VerseSelectionVersesProvider call({
    required VerseSelection selection,
    required BibleTranslation translation,
  }) => VerseSelectionVersesProvider._(
    argument: (selection: selection, translation: translation),
    from: this,
  );

  @override
  String toString() => r'verseSelectionVersesProvider';
}

@ProviderFor(verseSelectionText)
final verseSelectionTextProvider = VerseSelectionTextFamily._();

final class VerseSelectionTextProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  VerseSelectionTextProvider._({
    required VerseSelectionTextFamily super.from,
    required ({VerseSelection selection, BibleTranslation translation})
    super.argument,
  }) : super(
         retry: null,
         name: r'verseSelectionTextProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$verseSelectionTextHash();

  @override
  String toString() {
    return r'verseSelectionTextProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument =
        this.argument
            as ({VerseSelection selection, BibleTranslation translation});
    return verseSelectionText(
      ref,
      selection: argument.selection,
      translation: argument.translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VerseSelectionTextProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$verseSelectionTextHash() =>
    r'02ecc53b6324f1e9d15ac193185943e51586bccc';

final class VerseSelectionTextFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<String>,
          ({VerseSelection selection, BibleTranslation translation})
        > {
  VerseSelectionTextFamily._()
    : super(
        retry: null,
        name: r'verseSelectionTextProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VerseSelectionTextProvider call({
    required VerseSelection selection,
    required BibleTranslation translation,
  }) => VerseSelectionTextProvider._(
    argument: (selection: selection, translation: translation),
    from: this,
  );

  @override
  String toString() => r'verseSelectionTextProvider';
}

@ProviderFor(verseSelectionParagraphs)
final verseSelectionParagraphsProvider = VerseSelectionParagraphsFamily._();

final class VerseSelectionParagraphsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Paragraph>>,
          List<Paragraph>,
          FutureOr<List<Paragraph>>
        >
    with $FutureModifier<List<Paragraph>>, $FutureProvider<List<Paragraph>> {
  VerseSelectionParagraphsProvider._({
    required VerseSelectionParagraphsFamily super.from,
    required ({VerseSelection selection, BibleTranslation translation})
    super.argument,
  }) : super(
         retry: null,
         name: r'verseSelectionParagraphsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$verseSelectionParagraphsHash();

  @override
  String toString() {
    return r'verseSelectionParagraphsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Paragraph>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Paragraph>> create(Ref ref) {
    final argument =
        this.argument
            as ({VerseSelection selection, BibleTranslation translation});
    return verseSelectionParagraphs(
      ref,
      selection: argument.selection,
      translation: argument.translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VerseSelectionParagraphsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$verseSelectionParagraphsHash() =>
    r'bb04ef674b82127c99b19447acef8c5eecca231c';

final class VerseSelectionParagraphsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Paragraph>>,
          ({VerseSelection selection, BibleTranslation translation})
        > {
  VerseSelectionParagraphsFamily._()
    : super(
        retry: null,
        name: r'verseSelectionParagraphsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VerseSelectionParagraphsProvider call({
    required VerseSelection selection,
    required BibleTranslation translation,
  }) => VerseSelectionParagraphsProvider._(
    argument: (selection: selection, translation: translation),
    from: this,
  );

  @override
  String toString() => r'verseSelectionParagraphsProvider';
}

@ProviderFor(textSelectionText)
final textSelectionTextProvider = TextSelectionTextFamily._();

final class TextSelectionTextProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  TextSelectionTextProvider._({
    required TextSelectionTextFamily super.from,
    required BibleTextSelection super.argument,
  }) : super(
         retry: null,
         name: r'textSelectionTextProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$textSelectionTextHash();

  @override
  String toString() {
    return r'textSelectionTextProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as BibleTextSelection;
    return textSelectionText(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TextSelectionTextProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$textSelectionTextHash() => r'b95ea48c83f761368d2ce08afa4f60a700304124';

final class TextSelectionTextFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, BibleTextSelection> {
  TextSelectionTextFamily._()
    : super(
        retry: null,
        name: r'textSelectionTextProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TextSelectionTextProvider call(BibleTextSelection selection) =>
      TextSelectionTextProvider._(argument: selection, from: this);

  @override
  String toString() => r'textSelectionTextProvider';
}

@ProviderFor(annotationSelectionText)
final annotationSelectionTextProvider = AnnotationSelectionTextFamily._();

final class AnnotationSelectionTextProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  AnnotationSelectionTextProvider._({
    required AnnotationSelectionTextFamily super.from,
    required ({AnnotationSelection selection, BibleTranslation translation})
    super.argument,
  }) : super(
         retry: null,
         name: r'annotationSelectionTextProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$annotationSelectionTextHash();

  @override
  String toString() {
    return r'annotationSelectionTextProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument =
        this.argument
            as ({AnnotationSelection selection, BibleTranslation translation});
    return annotationSelectionText(
      ref,
      selection: argument.selection,
      translation: argument.translation,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AnnotationSelectionTextProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$annotationSelectionTextHash() =>
    r'6464b06e6da2ca41b3fd9328d1cb5ca8f1b74c14';

final class AnnotationSelectionTextFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<String>,
          ({AnnotationSelection selection, BibleTranslation translation})
        > {
  AnnotationSelectionTextFamily._()
    : super(
        retry: null,
        name: r'annotationSelectionTextProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AnnotationSelectionTextProvider call({
    required AnnotationSelection selection,
    required BibleTranslation translation,
  }) => AnnotationSelectionTextProvider._(
    argument: (selection: selection, translation: translation),
    from: this,
  );

  @override
  String toString() => r'annotationSelectionTextProvider';
}
