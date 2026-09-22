import 'package:bible/main.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/services/bible_navigation_service.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:lux/lux.dart';

class VerseOfTheDayPreview {
  static bool show(DateTime date) {
    final context = navigatorKey.currentContext;
    if (context == null) return false;

    final selection = ref.read(verseOfTheDaySelectionsProvider)[getVerseOfTheDayIndex(date)];
    context.goToRoot(
      onLoaded: (context) => PreviewPassageSheet.show(
        context,
        verseSelection: selection,
        onNavigateToVerseSelection: ref.read(bibleNavigationServiceProvider).navigateTo,
      ),
    );
    return true;
  }
}
