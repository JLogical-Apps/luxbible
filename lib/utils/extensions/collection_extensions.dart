import 'dart:math';

import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:collection/collection.dart';

extension BibleListExtensions<T> on List<T> {
  List<T> withToggle(T item) => contains(item) ? ([...this]..remove(item)) : [...this, item];

  List<T> withInsert(int index, T item) => [...this]..insert(index, item);
  List<T> withRemoved(T item) => [...this]..remove(item);
  List<T> withRemovedAt(int index) => [...this]..removeAt(index);

  List<T> withReorder(int oldIndex, int newIndex) {
    final items = [...this];
    final item = items.removeAt(oldIndex);
    return items..insert(newIndex, item);
  }

  List<T> withUpdate(bool Function(T) where, T Function(T) update) =>
      map((item) => where(item) ? update(item) : item).toList();

  List<T> withUpdateAt(int index, T Function(T) update) => [...this]..[index] = update(this[index]);

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

  List<T> sortedByIndexIn<T2>(List<T2> source, [T2 Function(T)? mapper]) =>
      sortedBy((e) => source.indexOfOrNull(mapper == null ? e as T2 : mapper(e)) ?? double.infinity);

  T get random => this[Random().nextInt(length)];

  T loopedElementAt(int index) => this[index % length];

  bool containsInOrder(List<T> list) => Iterable.generate(
    max(0, length - list.length + 1),
    (i) => i,
  ).any((i0) => list.everyIndexed((i1, item) => this[i0 + i1] == item));

  List<List<T>> batchBy(bool Function(T) predicate) {
    final output = <List<T>>[];
    var curr = <T>[];
    for (var item in this) {
      if (predicate(item)) {
        output.add(curr);
        curr = [];
      } else {
        curr.add(item);
      }
    }
    if (curr.isNotEmpty) {
      output.add(curr);
    }
    return output;
  }

  List<R> mapWithPrevious<R>(R Function(R?, T) mapper) =>
      fold(<R>[], (list, item) => list..add(mapper(list.lastOrNull, item)));

  List<T> maybeReversed(bool shouldReverse) => shouldReverse ? reversed.toList() : this;
}

extension BibleIterableExtensions<T> on Iterable<T> {
  bool containsAll(Iterable<T> list) => list.every((item) => contains(item));
  bool containsAny(Iterable<T> list) => list.any((item) => contains(item));

  List<T> sortedByDescending<K extends Comparable>(K Function(T) mapper) =>
      [...this]..sortByCompare(mapper, (a, b) => b.compareTo(a));

  bool anyIndexed(bool Function(int index, T) predicate) {
    for (var i = 0; i < length; i++) {
      if (predicate(i, elementAt(i))) {
        return true;
      }
    }
    return false;
  }

  bool everyIndexed(bool Function(int index, T) predicate) {
    for (var i = 0; i < length; i++) {
      if (!predicate(i, elementAt(i))) {
        return false;
      }
    }
    return true;
  }

  List<T> get distinct => toSet().toList();
  Iterable<T> distinctBy<R>(R Function(T) mapper) {
    final seen = <R>{};
    return toList()..retainWhere((e) => seen.add(mapper(e)));
  }

  T maxBy(num Function(T) numMapper) => reduce((a, b) => numMapper(a) > numMapper(b) ? a : b);
  T minBy(num Function(T) numMapper) => reduce((a, b) => numMapper(a) < numMapper(b) ? a : b);
  T? maxByOrNull(num Function(T) numMapper) => isEmpty ? null : reduce((a, b) => numMapper(a) > numMapper(b) ? a : b);
  T? minByOrNull(num Function(T) numMapper) => isEmpty ? null : reduce((a, b) => numMapper(a) < numMapper(b) ? a : b);
}

extension BibleMapEntryIterableExtensions<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map.fromEntries(this);
}

extension BibleFutureMapEntryIterableExtensions<K, V> on Iterable<Future<MapEntry<K, V>>> {
  Future<Map<K, V>> get waitToMap async => Map.fromEntries(await Future.wait(this));
}

extension BibleMapExtensions<K, V> on Map<K, V> {
  bool any(bool Function(K, V) predicate) => entries.any((entry) => predicate(entry.key, entry.value));
  bool every(bool Function(K, V) predicate) => entries.every((entry) => predicate(entry.key, entry.value));

  Map<K, V> sortedBy<E extends Comparable<E>>(E Function(K, V) elementGetter) =>
      entries.sortedBy((entry) => elementGetter(entry.key, entry.value)).toMap();
  Map<K, V> sortedByDescending<E extends Comparable<E>>(E Function(K, V) elementGetter) =>
      entries.sortedByDescending((entry) => elementGetter(entry.key, entry.value)).toMap();

  Map<K, V> withReorder(int oldIndex, int newIndex) => entries.toList().withReorder(oldIndex, newIndex).toMap();

  Map<K, V> withUpdate(K key, V Function(V) update) => containsKey(key) ? {...this, key: update(this[key] as V)} : this;

  Map<K, V> maybeSortedBy<E extends Comparable<E>>(E Function(K, V) elementGetter, {required bool shouldSort}) =>
      shouldSort ? entries.sortedBy((entry) => elementGetter(entry.key, entry.value)).toMap() : this;

  Map<K, V> take(int amount) => entries.take(amount).toMap();

  Map<K, V> withRemoved(K key) => {...this}..remove(key);

  Map<K, V> get withDistinctValues => entries.distinctBy((entry) => entry.value).toMap();
}

extension BibleNullKeyMapExtensions<K, V> on Map<K?, V> {
  Map<K, V> get withoutNullKeys =>
      entries.map((entry) => entry.key?.mapIfNonNull((key) => MapEntry(key, entry.value))).nonNulls.toMap();
}

extension BibleNullValueMapExtensions<K, V> on Map<K, V?> {
  Map<K, V> get withoutNullValues =>
      entries.map((entry) => entry.value?.mapIfNonNull((value) => MapEntry(entry.key, value))).nonNulls.toMap();
}

extension BibleIterableMapExtensions<K, V> on Iterable<Map<K, V>> {
  Map<K, V> get flattened => {for (final map in this) ...map};
}
