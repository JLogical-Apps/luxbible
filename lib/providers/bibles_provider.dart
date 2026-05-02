import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/bible/study/bible.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bibles_provider.g.dart';

@Riverpod(keepAlive: true)
List<DisplayBible> displayBibles(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
List<StudyBible> studyBibles(Ref ref) => throw UnimplementedError();
