extension Filter<T> on Stream<List<T>> {
  Stream<List<T>> filter(bool Function(T) where) {
    return map((item) => item.where(where).toList());
  }
}
