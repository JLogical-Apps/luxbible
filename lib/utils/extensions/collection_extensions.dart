extension ListExtensions<T> on List<T> {
  List<T> withToggle(T item) =>
      contains(item) ? ([...this]..remove(item)) : [...this, item];

  List<T> withRemoved(T item) => [...this]..remove(item);

  List<T> get distinct => toSet().toList();
}

extension MapExtensions<K, V> on Map<K, V> {
  Iterable<T> mapToIterable<T>(T Function(K, V) mapper) =>
      entries.map((entry) => mapper(entry.key, entry.value));
}
