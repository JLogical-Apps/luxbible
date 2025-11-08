extension ListExtensions<T> on List<T> {
  List<T> withToggle(T item) =>
      contains(item) ? ([...this]..remove(item)) : [...this, item];
}
