import 'package:bible/models/bible/paragraph.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/parsers/usx_parser.dart';

void main() {
  test('converts USX footnotes through the Markdown AST', () {
    final book = parseUsxBook(.matthew, '''
<usx version="3.0">
  <book code="MAT" style="id">Matthew</book>
  <chapter number="1" style="c"/>
  <para style="p">
    <verse number="1" style="v"/>Text
    <note style="f" caller="+"><char style="fr">1:1 </char><char style="ft">Or </char><char style="fqa">an account</char><char style="ft">; see </char><ref loc="ISA 7:14">Isaiah 7:14</ref></note>
  </para>
</usx>
''');

    final verse = (book.chapters.single.paragraphs.single as VersesParagraph).verses.single;
    expect(verse.footnotes?.single.text, 'Or *an account*; see [Isaiah 7:14](Isa.7.14)');
  });
}
