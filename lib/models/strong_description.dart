import 'package:bible/utils/markdown.dart';
import 'package:collection/collection.dart';

enum StrongDescriptionMarker {
  addedWord,
  idiomaticRendering,
  correctedVowelPointing;

  static StrongDescriptionMarker? fromRenderingOrNull(String rendering) =>
      values.firstWhereOrNull((marker) => rendering.startsWith('${marker.symbol} '));

  static StrongDescriptionMarker? fromLinkTarget(String target) =>
      values.firstWhereOrNull((marker) => marker.linkTarget == target);

  String get symbol => switch (this) {
    addedWord => '+',
    idiomaticRendering => 'X',
    correctedVowelPointing => 'º',
  };

  String get label => switch (this) {
    addedWord => 'added:',
    idiomaticRendering => 'idiom:',
    correctedVowelPointing => 'corrected vowel:',
  };

  String get title => switch (this) {
    addedWord => 'Added word',
    idiomaticRendering => 'Idiomatic rendering',
    correctedVowelPointing => 'Corrected vowel pointing',
  };

  String get description => switch (this) {
    addedWord => 'Marks a word supplied in the Authorized Version alongside the Hebrew or Greek word being defined.',
    idiomaticRendering => 'Marks a rendering that reflects an expression particular to Hebrew or Greek.',
    correctedVowelPointing =>
      'After a Hebrew word, marks vowel pointing corrected from the text, usually based on the marginal reading.',
  };

  String get linkTarget => 'strongs-description-marker:$name';
}

extension StrongDescriptionMarkdownExtension on Markdown {
  Markdown get withStrongDescriptionFormatting {
    final separatorIndex = text.lastIndexOf(': - ');
    if (separatorIndex == -1) return this;

    final explanation = text.substring(0, separatorIndex + 1);
    final renderings = _splitRenderings(text.substring(separatorIndex + ': -'.length));
    if (renderings.isEmpty) return this;

    return Markdown('$explanation\n${renderings.map(_formatRendering).join('\n')}');
  }
}

List<String> _splitRenderings(String text) => _mergeMarkedRenderingContinuations(_splitAtTopLevelCommas(text));

List<String> _splitAtTopLevelCommas(String text) {
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
    if (character != ',' || delimiterDepth > 0) return renderings;

    final rendering = text.substring(lastDelimiterIndex, index).trim();
    lastDelimiterIndex = index + 1;
    return [...renderings, if (rendering.isNotEmpty) rendering];
  });
  final finalRendering = text.substring(lastDelimiterIndex).trim();

  return [...renderings, if (finalRendering.isNotEmpty) finalRendering];
}

List<String> _mergeMarkedRenderingContinuations(Iterable<String> renderings) =>
    renderings.fold(<String>[], (mergedRenderings, rendering) {
      final previous = mergedRenderings.lastOrNull;
      if (previous != null && _isMarkedRendering(previous) && !_isMarkedRendering(rendering)) {
        return [...mergedRenderings.take(mergedRenderings.length - 1), '$previous, $rendering'];
      }
      return [...mergedRenderings, rendering];
    });

bool _isMarkedRendering(String rendering) => StrongDescriptionMarker.fromRenderingOrNull(rendering) != null;

String _formatRendering(String rendering) {
  final marker = StrongDescriptionMarker.fromRenderingOrNull(rendering);
  final content = marker == null ? rendering : rendering.substring(marker.symbol.length).trimLeft();
  final prefix = marker == null ? '' : '[${marker.label}](${marker.linkTarget}) ';

  return '- $prefix$content';
}
