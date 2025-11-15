import 'package:bible/models/bible.dart';
import 'package:bible/models/commentary.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class CommentaryImporter {
  Future<Commentary> import({required Bible bible}) async {
    final rawCommentary = await rootBundle.loadString('assets/commentary/matthew_henry.xml');
    final doc = XmlDocument.parse(rawCommentary);
    return Commentary(
      name: 'Matthew Henry',
      notes: doc
          .findAllElements('scripCom')
          .mapToMap(
            (com) => MapEntry(
              Passage.fromKey(com.getAttribute('osisRef')!.split(':').last, bible: bible),
              com.nextSibling!.getElement('p')?.innerText.replaceAll('\n', ''),
            ),
          )
          .withoutNullValues,
    );
  }
}
