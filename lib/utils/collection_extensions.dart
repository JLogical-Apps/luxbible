extension ListExtensions<T> on List<T> {
  List<T> withAdded(T item) => [...this, item];

  List<T> get distinct => toSet().toList();
}
