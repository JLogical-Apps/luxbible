import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:lux/lux.dart';
import 'package:xml/xml.dart';

class YouVersion {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.youversion.com',
      headers: {'x-yvp-app-key': 'UIFrcghkECmF1yy9KNy7akj073UqDcodMPk2eJa0BDpr6TDt'},
    ),
  )..interceptors.add(LogInterceptor(responseBody: false));

  static Future<Chapter> fetchChapter({required int bibleId, required ChapterReference chapterReference}) async {
    final response = await dio.get(
      '/v1/bibles/$bibleId/passages/${chapterReference.usxId()}',
      queryParameters: {'format': 'html', 'include_headings': true, 'include_notes': true},
    );

    final content = response.data['content'] as String;
    final root = XmlDocument.parse(content).rootElement;
    return XmlBibleParser.parse(
      root.childElements,
      getVerseNumber: (element) => element.classNames.contains('yv-v') ? int.parse(element.getAttribute('v')!) : null,
      shouldIgnore: (element) => element.classNames.contains('yv-vlbl'),
      buildFootnote: (element) => element.classNames.contains('yv-n') ? UsxUtils.noteToMarkdown(element) : null,
      isRedLetters: (element) => element.classNames.contains('wj'),
      isItalic: (element) => element.classNames.contains('it'),
      isUppercase: (element) => element.classNames.contains('sc'),
      getParagraphStyle: (element) => element.classNames.firstWhereOrNull((className) => !className.startsWith('yv-')),
      buildSectionText: (element) => element.children
          .where(
            (node) => switch (node) {
              XmlElement() => node.getAttribute('class')?.startsWith('yv-') != true,
              _ => true,
            },
          )
          .map(
            (node) => switch (node) {
              XmlText(:final value) => value,
              XmlElement() => node.innerText,
              _ => '',
            },
          )
          .join(),
      buildText: (text) => text,
    );
  }
}
