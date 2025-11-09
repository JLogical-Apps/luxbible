extension ObjectExtensions<T> on T {
  R? mapIfNonNull<R>(R Function(T) mapper) => this == null ? null : mapper(this);
}
