import 'package:lux/i18n.dart';

enum Testament {
  oldTestament,
  newTestament;

  String title() => switch (this) {
    oldTestament => t.testaments.old,
    newTestament => t.testaments.newTestament,
  };
}
