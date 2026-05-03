class TomlHelpers {
  static List<List<String>> parseNestedArray(String source) {
    final result = <List<String>>[];
    var i = 0;

    while (i < source.length - 1) {
      final code = source.codeUnitAt(i);
      if (code == 0x5B) {
        final (array, nextIndex) = parseStringArray(source, i);
        result.add(array);
        i = nextIndex;
      } else {
        i++;
      }
    }

    return result;
  }

  static (List<String>, int) parseStringArray(String source, int start) {
    final result = <String>[];
    var i = start + 1;

    while (source.codeUnitAt(i) != 0x5D) {
      if (source.codeUnitAt(i) == 0x22) {
        final (str, nextIndex) = parseString(source, i);
        result.add(str);
        i = nextIndex;
      } else {
        i++;
      }
    }

    return (result, i + 1);
  }

  static (String, int) parseString(String source, int start) {
    final endQuote = source.indexOf('"', start + 1);
    return (source.substring(start + 1, endQuote), endQuote + 1);
  }
}
