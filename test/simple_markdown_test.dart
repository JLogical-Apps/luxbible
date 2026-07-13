import 'package:bible/ui/widgets/simple_markdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses formatting nested around and inside links', () {
    final segments = parseSimpleMarkdown('**See [Genesis *1:1*](Gen.1.1)**');

    expect(segments.map((segment) => segment.text).join(), 'See Genesis 1:1');
    expect(segments, [
      (text: 'See ', fontWeight: FontWeight.bold, fontStyle: null, link: null, linkText: null),
      (text: 'Genesis ', fontWeight: FontWeight.bold, fontStyle: null, link: 'Gen.1.1', linkText: 'Genesis 1:1'),
      (text: '1:1', fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, link: 'Gen.1.1', linkText: 'Genesis 1:1'),
    ]);
  });

  testWidgets('passes link text and target when a link is pressed', (tester) async {
    final segments = parseSimpleMarkdown(r'See [12:6 \[sic\]](Lev.22.6)');
    expect(segments.map((segment) => (segment.text, segment.link, segment.linkText)).toList(), [
      ('See ', null, null),
      ('12:6 [sic]', 'Lev.22.6', '12:6 [sic]'),
    ]);

    String? pressedText;
    String? pressedLink;
    await tester.pumpWidget(
      MaterialApp(
        home: SimpleMarkdown(
          text: r'See [12:6 \[sic\]](Lev.22.6)',
          onLinkPressed: (text, link) {
            pressedText = text;
            pressedLink = link;
          },
        ),
      ),
    );

    final text = tester.widget<Text>(find.byType(Text));
    final spans = (text.textSpan as TextSpan).children!.whereType<TextSpan>();
    final recognizer = spans.map((span) => span.recognizer).whereType<TapGestureRecognizer>().first;
    recognizer.onTap!();

    expect(pressedText, '12:6 [sic]');
    expect(pressedLink, 'Lev.22.6');
  });
}
