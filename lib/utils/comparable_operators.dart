mixin ComparableOperators<T extends Comparable<T>> implements Comparable<T> {
  bool operator <(T reference) => compareTo(reference) < 0;
  bool operator <=(T reference) => compareTo(reference) <= 0;
  bool operator >(T reference) => compareTo(reference) > 0;
  bool operator >=(T reference) => compareTo(reference) >= 0;
}
