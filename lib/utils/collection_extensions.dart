extension ListExtensions<T> on List<T> {
  List<T> withAdded(T item) => [...this, item];
}
