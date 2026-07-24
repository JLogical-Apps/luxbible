import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/utils/usx_utils.dart';
import 'package:bible/utils/xml_bible_parser.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class ApiBible {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://rest.api.bible', headers: {'api-key': '19JTfW6nY4d_mB9RaSQ3y'}),
  )..interceptors.add(LogInterceptor(responseBody: false));

  static Future<Chapter> fetchChapter({required String bibleId, required ChapterReference chapterReference}) async {
    final response = await dio.get(
      '/v1/bibles/$bibleId/chapters/${chapterReference.usxId()}',
      queryParameters: {'include-notes': true},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    final content = data['content'] as String;
    final root = XmlDocument.parse('<root>$content</root>').rootElement;

    String cleanText(String text) => text.replaceAll('#', '');

    bool hasHelpfulText(XmlNode node, {bool isInsideReference = false}) => node.children.any(
      (child) => switch (child) {
        XmlText(:final value) => !isInsideReference && value.trim().isNotEmpty,
        XmlElement child => hasHelpfulText(
          child,
          isInsideReference: isInsideReference || child.classNames.contains('fr') || child.classNames.contains('xt'),
        ),
        _ => false,
      },
    );

    bool isOnlyCrossReference(XmlElement element) {
      if (element.classNames.contains('x')) return true;
      if (!element.classNames.contains('f')) return false;

      final hasCrossReference = element.descendants.whereType<XmlElement>().any(
        (child) => child.classNames.contains('xt'),
      );
      return hasCrossReference && !hasHelpfulText(element);
    }

    return XmlBibleParser.parse(
      root,
      getVerseNumber: (element) =>
          element.classNames.contains('v') ? int.parse(element.getAttribute('data-number')!) : null,
      shouldIgnore: isOnlyCrossReference,
      buildFootnote: (element) => element.classNames.contains('f') ? UsxUtils.noteToMarkdown(element) : null,
      isRedLetters: (element) => element.classNames.contains('wj'),
      isItalic: (element) => element.classNames.any(UsxUtils.isItalicStyle),
      getParagraphStyle: (element) => element.classNames.firstOrNull,
      buildSectionText: (element) => cleanText(element.innerText),
      buildText: cleanText,
    );
  }
}
