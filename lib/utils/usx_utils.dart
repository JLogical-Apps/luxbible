import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/markdown_utils.dart';
import 'package:xml/xml.dart';

abstract final class UsxUtils {
  static String noteToMarkdown(XmlElement note) => MarkdownUtils.fromXml(note, (element, children) {
    final styles = _stylesOf(element);
    if (styles.contains('fr')) return [];
    if (element.localName == 'ref' || styles.contains('ref')) {
      if (VerseSelection.tryFromUsxId(element.getAttribute('loc') ?? element.getAttribute('usfm'))
          case final selection?) {
        return [.link(selection.osisId(), children)];
      }
      return children;
    }
    return styles.any(isItalicStyle) ? [.italic(children)] : children;
  }).withCollapsedWhitespace.trim();

  static bool isItalicStyle(String? style) => switch (style) {
    'fqa' || 'fq' || 'fqb' || 'fk' || 'bk' || 'add' || 'tl' || 'qt' || 'it' || 'k' => true,
    _ => false,
  };

  static Set<String> _stylesOf(XmlElement element) => {
    ?element.getAttribute('style'),
    ...(element.getAttribute('class') ?? '').split(RegExp(r'\s+')).where((name) => name.isNotEmpty),
  };
}
