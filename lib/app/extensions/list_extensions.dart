extension ListReplaceExtension<T> on List<T> {
  void replaceWhere(bool Function(T) test, T replacement) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = replacement;
      }
    }
  }

  void replaceFirstWhere(bool Function(T) test, T replacement) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = replacement;
        break;
      }
    }
  }
}
