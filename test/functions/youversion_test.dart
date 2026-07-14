import 'package:bible/functions/youversion.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses the XML response without nesting self-closing verse markers', () {
    final chapter = YouVersion.parseChapter('''
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<div>
  <div class="s1 yv-h">The Genealogy</div>
  <div class="p">
    <span class="yv-v" v="1"/>
    <span class="yv-vlbl">1</span>
    This is the genealogy
    <span class="yv-n f"><span class="fr">1:1 </span><span class="ft">Or </span><span class="fqa">is an account</span><span class="ft">; see </span><span class="ref" usfm="ISA.7.14">Isaiah 7:14</span></span>
    of Jesus.
  </div>
</div>
''');

    expect((chapter.paragraphs.first as SectionParagraph).text, 'The Genealogy');
    final verse = (chapter.paragraphs.last as VersesParagraph).verses.single;
    expect(verse.text, contains('This is the genealogy'));
    expect(verse.text, contains('of Jesus.'));
    expect(verse.footnotes?.single.text, 'Or *is an account*; see [Isaiah 7:14](Isa.7.14)');
  });
}
