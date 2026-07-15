import 'package:bible/utils/markdown.dart';
import 'package:collection/collection.dart';

enum StrongDescriptionMarker {
  addedWord,
  idiomaticRendering;

  static StrongDescriptionMarker? fromRenderingOrNull(String rendering) =>
      values.firstWhereOrNull((marker) => rendering.startsWith('${marker.symbol} '));

  static StrongDescriptionMarker? fromLinkTarget(String target) =>
      values.firstWhereOrNull((marker) => marker.linkTarget == target);

  String get symbol => switch (this) {
    addedWord => '+',
    idiomaticRendering => 'X',
  };

  String get label => switch (this) {
    addedWord => 'added:',
    idiomaticRendering => 'idiom:',
  };

  String get title => switch (this) {
    addedWord => 'Added word',
    idiomaticRendering => 'Idiomatic rendering',
  };

  String get description => switch (this) {
    addedWord => 'Marks a word supplied in the Authorized Version alongside the Hebrew or Greek word being defined.',
    idiomaticRendering => 'Marks a rendering that reflects an expression particular to Hebrew or Greek.',
  };

  String get linkTarget => 'strongs-description-marker:$name';
}

extension StrongDescriptionMarkdownExtension on Markdown {
  Markdown get withStrongDescriptionFormatting {
    final separator = RegExp(r': -(\*)?\s*').allMatches(text).lastOrNull;
    if (separator == null) return this;

    final explanation = '${text.substring(0, separator.start)}${separator.group(1) ?? ''}:';
    final renderings = _splitRenderings(text.substring(separator.end));
    if (renderings.isEmpty) return this;

    return Markdown('$explanation\n${renderings.map(_formatRendering).join('\n')}');
  }
}

List<String> _splitRenderings(String text) => _splitAtTopLevelDelimiters(text);

List<String> _splitAtTopLevelDelimiters(String text) {
  var delimiterDepth = 0;
  var lastDelimiterIndex = 0;
  final renderings = text.codeUnits.indexed.fold(<String>[], (renderings, entry) {
    final (index, codeUnit) = entry;
    final character = String.fromCharCode(codeUnit);
    delimiterDepth += switch (character) {
      '(' || '[' => 1,
      ')' || ']' when delimiterDepth > 0 => -1,
      _ => 0,
    };
    if (!_isTopLevelDelimiter(text, index, character, delimiterDepth)) return renderings;

    final rendering = text.substring(lastDelimiterIndex, index).trim();
    lastDelimiterIndex = index + (character == ',' ? 1 : 0);
    return [...renderings, if (rendering.isNotEmpty) rendering];
  });
  final finalRendering = text.substring(lastDelimiterIndex).trim();

  return [...renderings, if (finalRendering.isNotEmpty) finalRendering];
}

bool _isTopLevelDelimiter(String text, int index, String character, int delimiterDepth) =>
    delimiterDepth == 0 &&
    (character == ',' ||
        StrongDescriptionMarker.values.any(
          (marker) => index > 0 && text[index - 1] == ' ' && text.startsWith('${marker.symbol} ', index),
        ));

String _formatRendering(String rendering) {
  final marker = StrongDescriptionMarker.fromRenderingOrNull(rendering);
  final content = marker == null ? rendering : rendering.substring(marker.symbol.length).trimLeft();
  final prefix = marker == null ? '' : '[${marker.label}](${marker.linkTarget}) ';

  return '- $prefix$content';
}
