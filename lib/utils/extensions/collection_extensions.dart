extension ListExtensions<T> on List<T> {
  List<T> withToggle(T item) =>
      contains(item) ? ([...this]..remove(item)) : [...this, item];

  List<T> withRemoved(T item) => [...this]..remove(item);

  List<T> get distinct => toSet().toList();
}
