import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_service.g.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;

  const SharedPreferencesService(this.sharedPreferences);

  ChapterReference? getLastChapterReference() {
    final bookTypeRaw = sharedPreferences.getString('referenceBookType');
    final chapterNum = sharedPreferences.getInt('referenceChapterNum');

    return bookTypeRaw == null || chapterNum == null
        ? null
        : ChapterReference(
            book: BookType.values.firstWhere((book) => book.name == bookTypeRaw),
            chapterNum: chapterNum,
          );
  }

  Future<void> setLastChapterReference(ChapterReference reference) async {
    await sharedPreferences.setString('referenceBookType', reference.book.name);
    await sharedPreferences.setInt('referenceChapterNum', reference.chapterNum);
  }
}

@riverpod
SharedPreferencesService sharedPreferenceService(Ref ref) => throw UnimplementedError();
