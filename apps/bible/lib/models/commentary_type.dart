import 'package:bible/i18n/strings.g.dart';

enum CommentaryType {
  matthewHenry,
  jamiesonFaussetBrown,
  calvin;

  String title() => switch (this) {
    matthewHenry => 'Matthew Henry',
    jamiesonFaussetBrown => 'Jamieson-Fausset-Brown',
    calvin => 'John Calvin',
  };

  String description() => switch (this) {
    matthewHenry => t.commentaryTypes.matthewHenryDescription,
    jamiesonFaussetBrown => t.commentaryTypes.jamiesonFaussetBrownDescription,
    calvin => t.commentaryTypes.calvinDescription,
  };
}
