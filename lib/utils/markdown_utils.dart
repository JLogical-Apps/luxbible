import 'package:collection/collection.dart';
import 'package:html/dom.dart' as dom;
import 'package:xml/xml.dart';

typedef XmlMarkdownBuilder = List<MarkdownElement> Function(XmlElement element, List<MarkdownElement> children);
typedef HtmlMarkdownBuilder = List<MarkdownElement> Function(dom.Element element, List<MarkdownElement> children);
typedef MarkdownTextBuilder = List<MarkdownElement> Function(String text);

enum MarkdownTextEscaping { none, linkText, all }

sealed class MarkdownElement {
  const MarkdownElement();

  const factory MarkdownElement.text(String text) = MarkdownText;
  const factory MarkdownElement.bold(List<MarkdownElement> children) = MarkdownBold;
  const factory MarkdownElement.italic(List<MarkdownElement> children) = MarkdownItalic;
  const factory MarkdownElement.link(String target, List<MarkdownElement> children) = MarkdownLink;
  const factory MarkdownElement.lineBreak() = MarkdownLineBreak;
  const factory MarkdownElement.paragraph(List<MarkdownElement> children) = MarkdownParagraph;
  const factory MarkdownElement.indented(int spaces, List<MarkdownElement> children) = MarkdownIndented;

  String get plainText;
}

final class MarkdownText extends MarkdownElement {
  final String text;

  const MarkdownText(this.text);

  @override
  String get plainText => text;
}

final class MarkdownBold extends MarkdownElement {
  final List<MarkdownElement> children;

  const MarkdownBold(this.children);

  @override
  String get plainText => children.plainText;
}

final class MarkdownItalic extends MarkdownElement {
  final List<MarkdownElement> children;

  const MarkdownItalic(this.children);

  @override
  String get plainText => children.plainText;
}

final class MarkdownLink extends MarkdownElement {
  final String target;
  final List<MarkdownElement> children;

  const MarkdownLink(this.target, this.children);

  @override
  String get plainText => children.plainText;
}

final class MarkdownLineBreak extends MarkdownElement {
  const MarkdownLineBreak();

  @override
  String get plainText => '\n';
}

final class MarkdownParagraph extends MarkdownElement {
  final List<MarkdownElement> children;

  const MarkdownParagraph(this.children);

  @override
  String get plainText => '${children.plainText}\n\n';
}

final class MarkdownIndented extends MarkdownElement {
  final int spaces;
  final List<MarkdownElement> children;

  const MarkdownIndented(this.spaces, this.children);

  @override
  String get plainText => '${''.padLeft(spaces, '\t')}${children.plainText}';
}

extension MarkdownElementsExtension on Iterable<MarkdownElement> {
  String get plainText => map((element) => element.plainText).join();
}

class MarkdownUtils {
  static final simpleMarkdownPattern = RegExp(
    r'(?<!\\)\[((?:\\.|[^\]])*)\]\((.+?)\)|(?<!\\)\*\*(.+?)(?<!\\)\*\*|(?<!\\)\*(.+?)(?<!\\)\*',
    dotAll: true,
  );

  static List<MarkdownElement> fromSimpleMarkdown(String text) {
    final matches = simpleMarkdownPattern.allMatches(text).toList();
    return [
      ...matches.indexed.expand((entry) {
        final (index, match) = entry;
        final gapStart = index == 0 ? 0 : matches[index - 1].end;
        final linkedText = match.group(1);
        final linkedTarget = match.group(2);
        final bold = match.group(3);
        final italic = match.group(4);
        final formatted = switch ((linkedText, linkedTarget, bold, italic)) {
          (final linkedText?, final linkedTarget?, _, _) => [
            MarkdownElement.link(linkedTarget, fromSimpleMarkdown(linkedText)),
          ],
          (_, _, final bold?, _) => [MarkdownElement.bold(fromSimpleMarkdown(bold))],
          (_, _, _, final italic?) => [MarkdownElement.italic(fromSimpleMarkdown(italic))],
          _ => <MarkdownElement>[],
        };
        return [
          if (match.start > gapStart) .text(_unescapeSimpleMarkdown(text.substring(gapStart, match.start))),
          ...formatted,
        ];
      }),
      if ((matches.lastOrNull?.end ?? 0) < text.length)
        .text(_unescapeSimpleMarkdown(text.substring(matches.lastOrNull?.end ?? 0))),
    ];
  }

  static String fromXml(
    XmlNode node,
    XmlMarkdownBuilder buildElement, {
    MarkdownTextBuilder? buildText,
    MarkdownTextEscaping textEscaping = .linkText,
  }) => fromXmlNodes([node], buildElement, buildText: buildText, textEscaping: textEscaping);

  static String fromXmlNodes(
    Iterable<XmlNode> nodes,
    XmlMarkdownBuilder buildElement, {
    MarkdownTextBuilder? buildText,
    MarkdownTextEscaping textEscaping = .linkText,
  }) => nodes.expand((node) => _fromXml(node, buildElement, buildText)).toList().render(textEscaping: textEscaping);

  static String fromHtml(
    dom.Node node,
    HtmlMarkdownBuilder buildElement, {
    MarkdownTextBuilder? buildText,
    MarkdownTextEscaping textEscaping = .linkText,
  }) => fromHtmlNodes([node], buildElement, buildText: buildText, textEscaping: textEscaping);

  static String fromHtmlNodes(
    Iterable<dom.Node> nodes,
    HtmlMarkdownBuilder buildElement, {
    MarkdownTextBuilder? buildText,
    MarkdownTextEscaping textEscaping = .linkText,
  }) => nodes.expand((node) => _fromHtml(node, buildElement, buildText)).toList().render(textEscaping: textEscaping);

  static List<MarkdownElement> _fromXml(
    XmlNode node,
    XmlMarkdownBuilder buildElement,
    MarkdownTextBuilder? buildText,
  ) => switch (node) {
    XmlText(:final value) => buildText?.call(value) ?? [.text(value)],
    XmlElement() => buildElement(
      node,
      node.children.expand((child) => _fromXml(child, buildElement, buildText)).toList(),
    ),
    _ => node.children.expand((child) => _fromXml(child, buildElement, buildText)).toList(),
  };

  static List<MarkdownElement> _fromHtml(
    dom.Node node,
    HtmlMarkdownBuilder buildElement,
    MarkdownTextBuilder? buildText,
  ) => switch (node) {
    dom.Text(:final data) => buildText?.call(data) ?? [.text(data)],
    dom.Element() => buildElement(
      node,
      node.nodes.expand((child) => _fromHtml(child, buildElement, buildText)).toList(),
    ),
    _ => node.nodes.expand((child) => _fromHtml(child, buildElement, buildText)).toList(),
  };

  static String _escapeMarkdown(String text) =>
      text.replaceAll(r'\', r'\\').replaceAll('*', r'\*').replaceAll('[', r'\[').replaceAll(']', r'\]');

  static String _escapeLinkText(String text) =>
      text.replaceAll(r'\', r'\\').replaceAll('[', r'\[').replaceAll(']', r'\]');

  static String _unescapeSimpleMarkdown(String text) =>
      text.replaceAllMapped(RegExp(r'\\(.)'), (match) => match.group(1) ?? '');

  static String _wrap(String text, String prefix, String suffix) {
    final core = text.trim();
    if (core.isEmpty) return text;

    final leading = text.substring(0, text.length - text.trimLeft().length);
    final trailing = text.substring(text.trimRight().length);
    return '$leading$prefix$core$suffix$trailing';
  }
}

extension on List<MarkdownElement> {
  String render({required MarkdownTextEscaping textEscaping}) => normalized
      .map(
        (element) => switch (element) {
          MarkdownText(:final text) => textEscaping == .all ? MarkdownUtils._escapeMarkdown(text) : text,
          MarkdownBold(:final children) => MarkdownUtils._wrap(children.render(textEscaping: textEscaping), '**', '**'),
          MarkdownItalic(:final children) => MarkdownUtils._wrap(children.render(textEscaping: textEscaping), '*', '*'),
          MarkdownLink(:final target, :final children) => MarkdownUtils._wrap(
            switch (textEscaping) {
              .linkText => MarkdownUtils._escapeLinkText(children.render(textEscaping: textEscaping)),
              .none || .all => children.render(textEscaping: textEscaping),
            },
            '[',
            ']($target)',
          ),
          MarkdownLineBreak() => '\n',
          MarkdownParagraph(:final children) => () {
            final text = children.render(textEscaping: textEscaping).replaceAll(RegExp(r'\s+'), ' ').trim();
            return text.isEmpty ? '' : '$text\n\n';
          }(),
          MarkdownIndented(:final spaces, :final children) => () {
            final text = children.render(textEscaping: textEscaping).trim();
            return text.isEmpty ? '' : '${''.padLeft(spaces)}$text';
          }(),
        },
      )
      .join();
}

extension on Iterable<MarkdownElement> {
  List<MarkdownElement> get normalized => expand(
    (element) => switch (element) {
      MarkdownBold(:final children) => children.bolded,
      MarkdownItalic(:final children) => children.italicized,
      MarkdownLink(:final target, :final children) => [MarkdownElement.link(target, children)],
      MarkdownParagraph(:final children) => [MarkdownElement.paragraph(children)],
      MarkdownIndented(:final spaces, :final children) => [MarkdownElement.indented(spaces, children)],
      _ => [element],
    },
  ).combined;

  List<MarkdownElement> get bolded => map(
    (element) => switch (element) {
      MarkdownBold() => element,
      MarkdownLink(:final target, :final children) => MarkdownElement.link(target, children.bolded),
      _ => MarkdownElement.bold([element]),
    },
  ).combined;

  List<MarkdownElement> get italicized => map(
    (element) => switch (element) {
      MarkdownItalic() => element,
      MarkdownLink(:final target, :final children) => MarkdownElement.link(target, children.italicized),
      _ => MarkdownElement.italic([element]),
    },
  ).combined;

  List<MarkdownElement> get combined => fold([], (normalized, element) {
    final previous = normalized.lastOrNull;
    final combined = switch ((previous, element)) {
      (MarkdownText(:final text), MarkdownText(text: final next)) => MarkdownElement.text('$text$next'),
      (MarkdownBold(:final children), MarkdownBold(children: final next)) => MarkdownElement.bold([
        ...children,
        ...next,
      ]),
      (MarkdownItalic(:final children), MarkdownItalic(children: final next)) => MarkdownElement.italic([
        ...children,
        ...next,
      ]),
      (
        MarkdownLink(target: final target, :final children),
        MarkdownLink(target: final nextTarget, children: final next),
      )
          when target == nextTarget =>
        MarkdownElement.link(target, [...children, ...next]),
      _ => null,
    };
    return combined == null ? [...normalized, element] : [...normalized.take(normalized.length - 1), combined];
  });
}
