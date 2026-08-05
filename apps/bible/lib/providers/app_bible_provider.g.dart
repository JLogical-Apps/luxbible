// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bible_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studyBible)
final studyBibleProvider = StudyBibleProvider._();

final class StudyBibleProvider extends $FunctionalProvider<AsyncValue<Bible>, Bible, FutureOr<Bible>>
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
  $FutureProviderElement<Bible> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Bible> create(Ref ref) {
    return studyBible(ref);
  }
}

String _$studyBibleHash() => r'38488664834ff466439fb919c22a900bde2538ec';

@ProviderFor(annotationSelectionText)
final annotationSelectionTextProvider = AnnotationSelectionTextFamily._();

final class AnnotationSelectionTextProvider extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  AnnotationSelectionTextProvider._({
    required AnnotationSelectionTextFamily super.from,
    required ({AnnotationSelection selection, BibleTranslation translation}) super.argument,
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
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as ({AnnotationSelection selection, BibleTranslation translation});
    return annotationSelectionText(ref, selection: argument.selection, translation: argument.translation);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnotationSelectionTextProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$annotationSelectionTextHash() => r'6464b06e6da2ca41b3fd9328d1cb5ca8f1b74c14';

final class AnnotationSelectionTextFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, ({AnnotationSelection selection, BibleTranslation translation})> {
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
  }) => AnnotationSelectionTextProvider._(argument: (selection: selection, translation: translation), from: this);

  @override
  String toString() => r'annotationSelectionTextProvider';
}
