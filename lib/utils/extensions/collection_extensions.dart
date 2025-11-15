import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:collection/collection.dart';

extension ListExtensions<T> on List<T> {
  List<T> withToggle(T item) =>
      contains(item) ? ([...this]..remove(item)) : [...this, item];

  List<T> withRemoved(T item) => [...this]..remove(item);
  List<T> withRemovedAt(int index) => [...this]..removeAt(index);

  List<T> get distinct => toSet().toList();

  int? indexOfOrNull(T? item) {
    if (item == null) {
      return null;
    }

    final index = indexOf(item);
    return index == -1 ? null : index;
  }

  int? indexWhereOrNull(bool Function(T) predicate) {
    final index = indexWhere(predicate);
    return index == -1 ? null : index;
  }

  int? lastIndexWhereOrNull(bool Function(T) predicate) {
    final index = lastIndexWhere(predicate);
    return index == -1 ? null : index;
  }

  List<T> sortedByIndexIn<T2>(List<T2> source, [T2 Function(T)? mapper]) => sortedBy(
    (e) => source.indexOfOrNull(mapper == null ? e as T2 : mapper(e)) ?? double.infinity,
  );
}

extension IterableExtensions<T> on Iterable<T> {
  bool containsAll(Iterable<T> list) => list.every((item) => contains(item));
  bool containsAny(Iterable<T> list) => list.any((item) => contains(item));

  Map<K, V> mapToMap<K, V>(MapEntry<K, V> Function(T) mapper) =>
      Map.fromEntries(map(mapper));
}

extension MapEntryIterableExtensions<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map.fromEntries(this);
}

extension MapExtensions<K, V> on Map<K, V> {
  Iterable<T> mapToIterable<T>(T Function(K, V) mapper) =>
      entries.map((entry) => mapper(entry.key, entry.value));

  Map<K, V> sortedBy<E extends Comparable<E>>(E Function(K, V) elementGetter) =>
      entries.sortedBy((entry) => elementGetter(entry.key, entry.value)).toMap();
}

extension NullValueMapExtensions<K, V> on Map<K, V?> {
  Map<K, V> get withoutNullValues => entries
      .map((entry) => entry.value?.mapIfNonNull((value) => MapEntry(entry.key, value)))
      .nonNulls
      .toMap();
}
