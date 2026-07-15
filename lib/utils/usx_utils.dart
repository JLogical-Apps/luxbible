import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/markdown.dart';
import 'package:xml/xml.dart';

abstract final class UsxUtils {
  static Markdown noteToMarkdown(XmlElement note) => Markdown.fromXml(note, (element, children) {
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
  }).text.withCollapsedWhitespace.trim().asMarkdown();

  static bool isItalicStyle(String? style) => switch (style) {
    'fqa' || 'fq' || 'fqb' || 'fk' || 'bk' || 'add' || 'tl' || 'qt' || 'it' || 'k' => true,
    _ => false,
  };

  static Set<String> _stylesOf(XmlElement element) => {
    ?element.getAttribute('style'),
    ...(element.getAttribute('class') ?? '').split(RegExp(r'\s+')).where((name) => name.isNotEmpty),
  };
}
