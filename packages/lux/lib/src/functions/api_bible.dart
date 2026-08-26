import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:lux/lux.dart';
import 'package:lux/src/functions/app_check_interceptor.dart';
import 'package:xml/xml.dart';

class ApiBible {
  static final Dio dio = Dio(BaseOptions(baseUrl: 'https://scripture.luxbible.app'))
    ..interceptors.addAll([AppCheckInterceptor(), LogInterceptor(requestHeader: false, responseBody: false)]);

  static Future<Chapter> fetchChapter({
    required String translationSlug,
    required ChapterReference chapterReference,
  }) async {
    final response = await dio.get<String>(
      '/$translationSlug/${chapterReference.usxId()}',
      options: Options(responseType: .plain),
    );

    final content = response.data!;
    final root = XmlDocument.parse('<root>${content.withoutWhitespaceBeforeFootnotes}</root>').rootElement;

    String cleanText(String text) => text.replaceAll('#', '').withRegularSpaces;

    bool hasHelpfulText(XmlNode node, {bool isInsideReference = false}) => node.children.any(
      (child) => switch (child) {
        XmlText(:final value) => !isInsideReference && value.trim().isNotEmpty,
        XmlElement child => hasHelpfulText(
          child,
          isInsideReference: isInsideReference || child.classNames.has('fr') || child.classNames.has('xt'),
        ),
        _ => false,
      },
    );

    bool isOnlyCrossReference(XmlElement element) {
      if (element.classNames.has('x')) return true;
      if (!element.classNames.has('f')) return false;

      final hasCrossReference = element.descendants.whereType<XmlElement>().any((child) => child.classNames.has('xt'));
      return hasCrossReference && !hasHelpfulText(element);
    }

    return XmlBibleParser.parse(
      root.childElements,
      getVerseNumber: (element) => element.classNames.has('v') ? int.parse(element.getAttribute('data-number')!) : null,
      shouldIgnore: isOnlyCrossReference,
      buildFootnote: (element) => element.classNames.has('f') ? UsxUtils.noteToMarkdown(element) : null,
      isRedLetters: (element) => element.classNames.has('wj'),
      isItalic: (element) => element.classNames.any(UsxUtils.isItalicStyle),
      isUppercase: (_) => false,
      getParagraphStyle: (element) => element.classNames.firstOrNull,
      buildSectionText: (element) => cleanText(element.innerText),
      buildText: cleanText,
    );
  }
}

extension on String {
  String get withoutWhitespaceBeforeFootnotes => replaceAll(RegExp(r'\s+(?=<span[^>]*class="[^"]*\bf\b[^"]*")'), '');

  String get withRegularSpaces => replaceAll('\u00a0', ' ');
}
