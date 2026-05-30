import 'package:bible/models/bible/bible.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bibles_provider.g.dart';

@Riverpod(keepAlive: true)
List<Bible> bibles(Ref ref) => throw UnimplementedError();

@riverpod
Bible studyBible(Ref ref) => ref.watch(biblesProvider).firstWhere((bible) => bible.translation == .bsb);

@riverpod
Bible bible(Ref ref) {
  final user = ref.watch(userProvider);
  final bibles = ref.watch(biblesProvider);
  return user.getBible(bibles);
}
