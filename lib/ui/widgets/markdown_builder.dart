import 'package:bible/utils/hook_utils.dart';
import 'package:bible/utils/markdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MarkdownBuilder extends HookWidget {
  final Markdown markdown;
  final void Function(String text, String link)? onLinkPressed;

  final int? maxLines;

  const MarkdownBuilder(this.markdown, {super.key, this.onLinkPressed, this.maxLines});

  @override
  Widget build(BuildContext context) {
    final elements = useMemoized(() => markdown.elements, [markdown]);
    final (:spans, :recognizers) = useDisposable(
      useMemoized(() {
        final recognizers = <TapGestureRecognizer>[];
        final spans = getTextSpans(elements, recognizers);
        return (spans: spans, recognizers: recognizers);
      }, [elements, onLinkPressed]),
      (rendered) {
        for (final recognizer in rendered.recognizers) {
          recognizer.dispose();
        }
      },
    );

    return Text.rich(
      maxLines: maxLines,
      overflow: maxLines == null ? null : .ellipsis,
      TextSpan(children: spans),
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
