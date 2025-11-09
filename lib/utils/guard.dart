T? guard<T>(T Function() function) {
  try {
    return function();
  } catch (e) {
    return null;
  }
}
