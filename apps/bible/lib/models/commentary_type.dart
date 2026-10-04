import 'package:lux/i18n.dart';

enum CommentaryType {
  tyndale,
  matthewHenry,
  jamiesonFaussetBrown,
  calvin;

  String title() => switch (this) {
    tyndale => 'Tyndale Study Notes',
    matthewHenry => 'Matthew Henry',
    jamiesonFaussetBrown => 'Jamieson-Fausset-Brown',
    calvin => 'John Calvin',
  };

  String description() => switch (this) {
    tyndale => t.commentaryTypes.tyndaleDescription,
    matthewHenry => t.commentaryTypes.matthewHenryDescription,
    jamiesonFaussetBrown => t.commentaryTypes.jamiesonFaussetBrownDescription,
    calvin => t.commentaryTypes.calvinDescription,
  };
}
