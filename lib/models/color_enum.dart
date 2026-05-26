import 'package:bible/style/style.dart';

enum ColorEnum {
  red,
  orange,
  yellow,
  green,
  blue,
  violet,
  stone;

  String title() => switch (this) {
    red => 'Red',
    orange => 'Orange',
    yellow => 'Yellow',
    green => 'Green',
    blue => 'Blue',
    violet => 'Violet',
    stone => 'Silver',
  };

  Hue toHue(ColorLibrary colors) => switch (this) {
    red => colors.red,
    orange => colors.orange,
    yellow => colors.yellow,
    green => colors.green,
    blue => colors.blue,
    violet => colors.violet,
    stone => colors.stone,
  };
}
