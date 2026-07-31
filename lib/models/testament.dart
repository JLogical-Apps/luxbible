import 'package:bible/i18n/strings.g.dart';

enum Testament {
  oldTestament,
  newTestament;

  String title() => switch (this) {
    oldTestament => t.testaments.old,
    newTestament => t.testaments.newTestament,
  };
}
