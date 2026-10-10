// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan_study_notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biblePlanStudyNotes)
final biblePlanStudyNotesProvider = BiblePlanStudyNotesFamily._();

final class BiblePlanStudyNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BiblePlanStudyNote>>,
          List<BiblePlanStudyNote>,
          FutureOr<List<BiblePlanStudyNote>>
        >
    with
        $FutureModifier<List<BiblePlanStudyNote>>,
        $FutureProvider<List<BiblePlanStudyNote>> {
  BiblePlanStudyNotesProvider._({
    required BiblePlanStudyNotesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'biblePlanStudyNotesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$biblePlanStudyNotesHash();

  @override
  String toString() {
    return r'biblePlanStudyNotesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BiblePlanStudyNote>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BiblePlanStudyNote>> create(Ref ref) {
    final argument = this.argument as String;
    return biblePlanStudyNotes(ref, planId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BiblePlanStudyNotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$biblePlanStudyNotesHash() =>
    r'808a64e5e2aa51097abe76c1af2c820b8c93869f';

final class BiblePlanStudyNotesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BiblePlanStudyNote>>, String> {
  BiblePlanStudyNotesFamily._()
    : super(
        retry: null,
        name: r'biblePlanStudyNotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  BiblePlanStudyNotesProvider call({required String planId}) =>
      BiblePlanStudyNotesProvider._(argument: planId, from: this);

  @override
  String toString() => r'biblePlanStudyNotesProvider';
}
