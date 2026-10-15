import 'package:lux/lux.dart';

enum Tutorial { interlinearStudy, crossReferencesStudy, searchStudy, articlePassagesStudy }

class KnownTutorials extends KnownEnumSet<Tutorial> {
  const KnownTutorials() : super(Tutorial.values);
}
