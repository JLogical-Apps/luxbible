import 'package:flutter/services.dart';

class TomlImporter {
  Future<Map<String, dynamic>> load(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return parse(raw);
  }

  static Map<String, dynamic> parse(String source) {
    final result = <String, dynamic>{};
    Map<String, dynamic>? currentSection;

    for (final line in source.split('\n')) {
      if (line.isEmpty) continue;

      if (line.codeUnitAt(0) == 0x5B) {
        currentSection = _parseSection(result, line);
      } else {
        currentSection!.addAll(_parseKeyValue(line));
      }
    }

    return result;
  }

  static Map<String, dynamic> _parseSection(Map<String, dynamic> root, String line) {
    final dotIndex = line.indexOf('.');
    final topKey = line.substring(1, dotIndex);
    final subKey = line.substring(dotIndex + 1, line.length - 1);

    final topMap = root.putIfAbsent(topKey, () => <String, dynamic>{}) as Map<String, dynamic>;
    return topMap.putIfAbsent(subKey, () => <String, dynamic>{}) as Map<String, dynamic>;
  }

  static Map<String, dynamic> _parseKeyValue(String line) {
    final eqIndex = line.indexOf(' = ');
    final key = line.substring(0, eqIndex);
    final value = _parseNestedArray(line, eqIndex + 3);
    return {key: value};
  }

  static List<List<String>> _parseNestedArray(String source, int start) {
    final result = <List<String>>[];
    var i = start + 1; // skip outer '['

    while (i < source.length - 1) {
      final code = source.codeUnitAt(i);
      if (code == 0x5B) {
        final (array, nextIndex) = _parseStringArray(source, i);
        result.add(array);
        i = nextIndex;
      } else {
        i++;
      }
    }

    return result;
  }

  static (List<String>, int) _parseStringArray(String source, int start) {
    final result = <String>[];
    var i = start + 1; // skip '['

    while (source.codeUnitAt(i) != 0x5D) {
      if (source.codeUnitAt(i) == 0x22) {
        final (str, nextIndex) = _parseString(source, i);
        result.add(str);
        i = nextIndex;
      } else {
        i++;
      }
    }

    return (result, i + 1);
  }

  static (String, int) _parseString(String source, int start) {
    final endQuote = source.indexOf('"', start + 1);
    return (source.substring(start + 1, endQuote), endQuote + 1);
  }
}
