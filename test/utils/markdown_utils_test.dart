import 'package:bible/utils/markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart';
import 'package:xml/xml.dart';

void main() {
  test('parses simple Markdown into nested elements', () {
    final elements = Markdown(r'plain **bold [link](target)** and *italic*').elements;

    expect(elements.plainText, 'plain bold link and italic');
    expect(elements[1], isA<MarkdownBold>());
    expect((elements[1] as MarkdownBold).children.whereType<MarkdownLink>(), hasLength(1));
    expect(elements[3], isA<MarkdownItalic>());
  });

  test('converts XML from the innermost element outward', () {
    final xml = XmlDocument.parse('<p>Before <b>bold <i>and italic</i></b><skip>discarded</skip>.</p>');

    expect(
      Markdown.fromXml(
        xml,
        (element, children) => switch (element.name.local) {
          'b' => [.bold(children)],
          'i' => [.italic(children)],
          'skip' => [],
          _ => children,
        },
      ).text,
      'Before **bold *and italic***.',
    );
  });

  test('converts HTML through the same Markdown AST', () {
    final html = parseFragment('<p>See <a href="G1"><b>G1</b></a><br>next</p>');

    expect(
      Markdown.fromHtml(
        html,
        (element, children) => switch (element.localName) {
          'a' => [
            .link(element.attributes['href']!, [.text(children.plainText)]),
          ],
          'b' => [.bold(children)],
          'br' => [.lineBreak()],
          _ => children,
        },
      ).text,
      'See [G1](G1)\nnext',
    );
  });

  test('escapes text and keeps whitespace outside Markdown markers', () {
    final xml = XmlDocument.parse(r'<p><i> [text]* </i>after</p>');

    expect(
      Markdown.fromXml(
        xml,
        (element, children) => element.name.local == 'i' ? [.italic(children)] : children,
        textEscaping: .all,
      ).text,
      r' *\[text\]\** after',
    );
  });

  test('combines adjacent elements with the same formatting', () {
    final xml = XmlDocument.parse('<p><i>one<i> nested</i></i><i> adjacent</i></p>');

    expect(
      Markdown.fromXml(xml, (element, children) => element.name.local == 'i' ? [.italic(children)] : children).text,
      '*one nested adjacent*',
    );
  });

  test('can keep links outside inherited formatting', () {
    final xml = XmlDocument.parse('<p><i>see <ref>Isaiah</ref>.</i></p>');

    expect(
      Markdown.fromXml(
        xml,
        (element, children) => switch (element.name.local) {
          'i' => [.italic(children)],
          'ref' => [.link('Isa.1.1', children)],
          _ => children,
        },
      ).text,
      '*see* [*Isaiah*](Isa.1.1)*.*',
    );
  });

  test('renders multiple XML paragraphs as blocks', () {
    final xml = XmlDocument.parse('<root><p>first\nline</p><p><i> second </i></p></root>');

    expect(
      Markdown.fromXmlNodes(
        xml.rootElement.findElements('p'),
        (element, children) => switch (element.name.local) {
          'p' => [.paragraph(children)],
          'i' => [.italic(children)],
          _ => children,
        },
      ).text,
      'first line\n\n*second*\n\n',
    );
  });

  test('indents trimmed HTML content', () {
    final html = parseFragment('<p> value </p>').children.single;

    expect(
      Markdown.fromHtml(
        html,
        (element, children) => element.localName == 'p' ? [.indented(4, children)] : children,
      ).text,
      '    value',
    );
  });
}
