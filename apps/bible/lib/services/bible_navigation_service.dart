import 'package:flutter/foundation.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_navigation_service.g.dart';

// Lets entry points outside the reader's widget tree (links, notifications, the widget) navigate it.
class BibleNavigationService extends ChangeNotifier {
  VerseSelection? _requestedSelection;

  VerseSelection? get requestedSelection => _requestedSelection;

  void navigateTo(VerseSelection selection) {
    _requestedSelection = selection;
    notifyListeners();
  }

  void clearRequest() {
    _requestedSelection = null;
    notifyListeners();
  }
}

@Riverpod(keepAlive: true)
BibleNavigationService bibleNavigationService(Ref ref) => BibleNavigationService();
