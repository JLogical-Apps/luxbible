import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cross_references_provider.g.dart';

@riverpod
Map<Reference, Map<VerseSpanReference, int>> crossReferences(Ref ref) => throw UnimplementedError();
