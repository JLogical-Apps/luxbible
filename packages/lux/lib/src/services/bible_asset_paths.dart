import 'package:lux/src/models/bible/bible_translation.dart';

abstract final class BibleAssetPaths {
  static String translation(BibleTranslation translation) => 'assets/translations/${translation.name}.json';
}
