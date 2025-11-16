import 'package:bible/models/commentary.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class CommentaryImporter {
  Future<Commentary> import() async {
    final rawCommentary = await rootBundle.loadString('assets/commentary/matthew_henry.xml');
    final doc = XmlDocument.parse(rawCommentary);
    return Commentary(
      name: 'Matthew Henry',
      notes: doc
          .findAllElements('scripCom')
          .mapToMap(
            (com) => MapEntry(
              Passage.fromOsisId(com.getAttribute('osisRef')!.split(':').last),
              com.nextSibling!.getElement('p')?.innerText.replaceAll('\n', ''),
            ),
          )
          .withoutNullValues,
    );
  }
}
