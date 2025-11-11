import 'package:bible/style/color_library.dart';
import 'package:bible/style/hue.dart';

enum ColorEnum {
  red,
  orange,
  yellow,
  green,
  blue,
  violet,
  stone;

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
