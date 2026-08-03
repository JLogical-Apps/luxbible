import 'package:lux/i18n.dart';
import 'package:style/style.dart';

enum ColorEnum {
  red,
  orange,
  yellow,
  green,
  blue,
  violet,
  stone;

  String title() => switch (this) {
    red => t.colors.red,
    orange => t.colors.orange,
    yellow => t.colors.yellow,
    green => t.colors.green,
    blue => t.colors.blue,
    violet => t.colors.violet,
    stone => t.colors.silver,
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
