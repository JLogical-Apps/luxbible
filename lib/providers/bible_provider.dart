import 'package:bible/models/bible.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_provider.g.dart';

@Riverpod(keepAlive: true)
List<Bible> bibles(Ref ref) => throw UnimplementedError();
