import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:bible/utils/markdown.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MarkdownBuilder extends HookWidget {
  final Markdown markdown;
  final void Function(String text, String link)? onLinkPressed;

  final TextStyle? style;
  final int? maxLines;

  const MarkdownBuilder(this.markdown, {super.key, this.onLinkPressed, this.style, this.maxLines});

  @override
  Widget build(BuildContext context) {
    final lines = useMemoized(() => markdown.text.split('\n').map(MarkdownLine.fromText).toList(), [markdown]);
    final hasIndentedLines = lines.any((line) => line.indentation > 0);

    final (:spansByLine, :recognizers) = useDisposable(
      useMemoized(() {
        final recognizers = <TapGestureRecognizer>[];
        final spansByLine = hasIndentedLines
            ? lines.map((line) => getTextSpans(line.markdown.elements, recognizers)).toList()
            : [getTextSpans(markdown.elements, recognizers)];
        return (spansByLine: spansByLine, recognizers: recognizers);
      }, [lines, hasIndentedLines, onLinkPressed]),
      (rendered) {
        for (final recognizer in rendered.recognizers) {
          recognizer.dispose();
        }
      },
    );

    final indentationWidth = DefaultTextStyle.of(context).style.getWidth('   ');
    return Column(
      crossAxisAlignment: .stretch,
      children: spansByLine
          .mapIndexed(
            (index, spans) => Padding(
              padding: .only(left: lines[index].indentation * indentationWidth),
              child: MarkdownRichText(spans: spans, maxLines: maxLines, style: style),
            ),
          )
          .toList(),
    );
  }

  List<InlineSpan> getTextSpans(
    Iterable<MarkdownElement> elements,
    List<TapGestureRecognizer> recognizers, {
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? link,
    String? linkText,
  }) => elements
      .expand(
        (element) => switch (element) {
          MarkdownText(:final text) => [
            TextSpan(
              text: text.replaceAll('\t', ''.padLeft(3)),
              style: TextStyle(
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                decoration: link == null ? null : .underline,
              ),
              recognizer: link == null || linkText == null ? null : linkRecognizer(linkText, link, recognizers),
            ),
          ],
          MarkdownBold(:final children) => getTextSpans(
            children,
            recognizers,
            fontWeight: .bold,
            fontStyle: fontStyle,
            link: link,
            linkText: linkText,
          ),
          MarkdownItalic(:final children) => getTextSpans(
            children,
            recognizers,
            fontWeight: fontWeight,
            fontStyle: .italic,
            link: link,
            linkText: linkText,
          ),
          MarkdownLink(:final target, :final children) => getTextSpans(
            children,
            recognizers,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            link: target,
            linkText: children.plainText,
          ),
          MarkdownLineBreak() => [TextSpan(text: '\n')],
          MarkdownParagraph(:final children) => [...getTextSpans(children, recognizers), TextSpan(text: '\n\n')],
          MarkdownIndented(:final spaces, :final children) => [
            TextSpan(text: ''.padLeft(spaces)),
            ...getTextSpans(children, recognizers),
          ],
        },
      )
      .toList();

  TapGestureRecognizer? linkRecognizer(String linkText, String link, List<TapGestureRecognizer> recognizers) {
    final onLinkPressed = this.onLinkPressed;
    if (onLinkPressed == null) return null;

    final recognizer = TapGestureRecognizer()..onTap = () => onLinkPressed(linkText, link);
    recognizers.add(recognizer);
    return recognizer;
  }
}

class MarkdownLine {
  final int indentation;
  final Markdown markdown;

  const MarkdownLine({required this.indentation, required this.markdown});

  factory MarkdownLine.fromText(String text) {
    final indentation = RegExp(r'^\t*').firstMatch(text)!.end;
    return MarkdownLine(indentation: indentation, markdown: Markdown(text.substring(indentation)));
  }
}

class MarkdownRichText extends StatelessWidget {
  final List<InlineSpan> spans;
  final TextStyle? style;
  final int? maxLines;

  const MarkdownRichText({super.key, required this.spans, this.style, this.maxLines});

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(children: spans),
    maxLines: maxLines,
    overflow: maxLines == null ? null : .ellipsis,
    style: style,
  );
}
