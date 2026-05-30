import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';

void main() {
  final rawXml = File('source_files/commentary/matthew_henry.xml').readAsStringSync();
  final doc = XmlDocument.parse(rawXml);

  final notes = <String, String>{};
  for (final com in doc.findAllElements('scripCom')) {
    final osisRef = com.getAttribute('osisRef');
    if (osisRef == null) continue;
    final key = osisRef.split(':').last;
    final text = com.nextSibling?.getElement('p')?.innerText.replaceAll('\n', '');
    if (text != null && text.isNotEmpty) notes[key] = text;
  }

  final json = {'n': 'Matthew Henry', 'v': notes};
  File('assets/commentary/matthew_henry.json').writeAsStringSync(jsonEncode(json));
}
