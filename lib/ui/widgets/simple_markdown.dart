import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef SimpleMarkdownSegment = ({
  String text,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  String? link,
  String? linkText,
});

class SimpleMarkdown extends HookWidget {
  final String text;
  final void Function(String text, String link)? onLinkPressed;

  const SimpleMarkdown({super.key, required this.text, this.onLinkPressed});

  static final pattern = RegExp(r'\[((?:\\.|[^\]])*)\]\((.+?)\)|\*\*(.+?)\*\*|\*(.+?)\*', dotAll: true);

  @override
  Widget build(BuildContext context) {
    final segments = useMemoized(() => parseSimpleMarkdown(text), [text]);
    final linkRecognizers = useDisposable(
      useMemoized(
        () => segments.map((segment) {
          final link = segment.link;
          final linkText = segment.linkText;
          final onLinkPressed = this.onLinkPressed;
          return link == null || linkText == null || onLinkPressed == null
              ? null
              : (TapGestureRecognizer()..onTap = () => onLinkPressed(linkText, link));
        }).toList(),
        [segments, onLinkPressed],
      ),
      (recognizers) {
        for (var recognizer in recognizers.nonNulls) {
          recognizer.dispose();
        }
      },
    );

    return Text.rich(
      TextSpan(
        children: segments
            .mapIndexed(
              (index, segment) => TextSpan(
                text: segment.text,
                style: TextStyle(
                  fontWeight: segment.fontWeight,
                  fontStyle: segment.fontStyle,
                  decoration: segment.link == null ? null : .underline,
                ),
                recognizer: linkRecognizers[index],
              ),
            )
            .toList(),
      ),
    );
  }

  List<SimpleMarkdownSegment> parseSimpleMarkdown(
    String text, {
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? link,
    String? linkText,
  }) {
    final matches = SimpleMarkdown.pattern.allMatches(text).toList();
    return [
      ...matches.mapIndexed((index, match) {
        final gapStart = index == 0 ? 0 : matches[index - 1].end;
        final linkedText = match.group(1);
        final linkedTarget = match.group(2);
        final bold = match.group(3);
        final italic = match.group(4);
        final formatted = switch ((linkedText, linkedTarget, bold, italic)) {
          (final linkedText?, final linkedTarget?, _, _) => () {
            final segments = parseSimpleMarkdown(
              linkedText,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              link: linkedTarget,
            );
            final linkText = segments.map((segment) => segment.text).join();
            return segments
                .map(
                  (segment) => (
                    text: segment.text,
                    fontWeight: segment.fontWeight,
                    fontStyle: segment.fontStyle,
                    link: segment.link,
                    linkText: linkText,
                  ),
                )
                .toList();
          }(),
          (_, _, final bold?, _) => parseSimpleMarkdown(
            bold,
            fontWeight: .bold,
            fontStyle: fontStyle,
            link: link,
            linkText: linkText,
          ),
          (_, _, _, final italic?) => parseSimpleMarkdown(
            italic,
            fontWeight: fontWeight,
            fontStyle: .italic,
            link: link,
            linkText: linkText,
          ),
          _ => [],
        };
        return [
          if (match.start > gapStart)
            (
              text: unescapeSimpleMarkdown(text.substring(gapStart, match.start)),
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              link: link,
              linkText: linkText,
            ),
          ...formatted,
        ];
      }).flattened,
      if ((matches.lastOrNull?.end ?? 0) < text.length)
        (
          text: unescapeSimpleMarkdown(text.substring(matches.lastOrNull?.end ?? 0)),
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          link: link,
          linkText: linkText,
        ),
    ];
  }

  String unescapeSimpleMarkdown(String text) =>
      text.replaceAllMapped(RegExp(r'\\(.)'), (match) => match.group(1) ?? '');
}
