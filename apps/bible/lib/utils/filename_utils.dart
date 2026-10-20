import 'package:path/path.dart' as path;

String getSafeFilename(String name, {required String extension, required String fallback}) {
  final withoutExtension = path.extension(name).toLowerCase() == extension ? path.withoutExtension(name) : name;
  final sanitized = withoutExtension.withInvalidFilenameCharactersReplaced.withoutTrailingFilenameDotsOrSpaces.trim();
  final safeName = sanitized.isEmpty ? fallback : String.fromCharCodes(sanitized.runes.take(100));
  return path.setExtension(safeName, extension);
}

extension on String {
  String get withInvalidFilenameCharactersReplaced => replaceAll(RegExp(r'[\\/:*?"<>|\x00-\x1F]'), '_');

  String get withoutTrailingFilenameDotsOrSpaces => replaceAll(RegExp(r'[. ]+$'), '');
}
