import 'package:collection/collection.dart';

extension EnumListExtensions<E extends Enum> on List<E> {
  E? byNameOrNull(String name) => firstWhereOrNull((value) => value.name == name);
}
