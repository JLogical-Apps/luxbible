import 'dart:convert';
import 'dart:typed_data';

import 'package:bible/models/notebook_file.dart';
import 'package:bible/utils/filename_utils.dart';

class NotebookFileService {
  static const fileExtension = 'lxn';
  static const mimeType = 'application/vnd.luxbible.notebook+json';
  static const uniformTypeIdentifier = 'app.luxbible.notebook';

  static NotebookFile? decode(String contents) {
    try {
      final file = NotebookFile.fromJson(jsonDecode(contents) as Map<String, dynamic>);
      return file.isValid ? file : null;
    } catch (_) {
      return null;
    }
  }

  static String encode(NotebookFile file) => jsonEncode(file.toJson());

  static Uint8List getBytes(NotebookFile file) => Uint8List.fromList(utf8.encode(encode(file)));

  static String getFilename(String name) => getSafeFilename(name, extension: '.$fileExtension', fallback: 'Notebook');
}
