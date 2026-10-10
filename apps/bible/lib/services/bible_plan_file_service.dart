import 'dart:convert';
import 'dart:typed_data';

import 'package:bible/models/bible_plan.dart';
import 'package:path/path.dart' as path;

class BiblePlanFileException implements Exception {
  final BiblePlanFileError error;

  const BiblePlanFileException(this.error);
}

enum BiblePlanFileError {
  malformedJson,
  invalidStructure,
  nameRequired,
  invalidDayCount,
  readingRequired,
  invalidPassage,
  duplicatePassage,
  readFailed,
}

class BiblePlanFileImport {
  final BiblePlan? plan;
  final BiblePlanFileError? error;

  const BiblePlanFileImport.success(BiblePlan this.plan) : error = null;

  const BiblePlanFileImport.failure(BiblePlanFileError this.error) : plan = null;

  factory BiblePlanFileImport.decode(String contents) {
    try {
      return .success(BiblePlanFileService.decode(contents));
    } on BiblePlanFileException catch (exception) {
      return .failure(exception.error);
    } catch (_) {
      return .failure(.readFailed);
    }
  }
}

class BiblePlanFileService {
  static const mimeType = 'application/vnd.luxbible.plan+json';

  static BiblePlan decode(String contents) {
    final Object? json;
    try {
      json = jsonDecode(contents);
    } on FormatException {
      throw BiblePlanFileException(.malformedJson);
    }

    final BiblePlan plan;
    try {
      plan = BiblePlan.fromJson(json as Map<String, dynamic>);
    } catch (_) {
      throw BiblePlanFileException(.invalidStructure);
    }

    if (plan.validationError case final error?) {
      throw BiblePlanFileException(switch (error) {
        .nameRequired => .nameRequired,
        .invalidDayCount => .invalidDayCount,
        .readingRequired => .readingRequired,
        .invalidPassage => .invalidPassage,
        .duplicatePassage => .duplicatePassage,
      });
    }
    return plan;
  }

  static String encode(BiblePlan plan, {required String displayName}) =>
      jsonEncode(plan.copyWith(name: displayName).toJson());

  static Uint8List getBytes(BiblePlan plan, {required String displayName}) =>
      Uint8List.fromList(utf8.encode(encode(plan, displayName: displayName)));

  static String getFilename(String displayName) {
    final withoutExtension = path.extension(displayName).toLowerCase() == '.lxbp'
        ? path.withoutExtension(displayName)
        : displayName;
    final sanitized = withoutExtension.withInvalidFilenameCharactersReplaced.withoutTrailingFilenameDotsOrSpaces.trim();
    final safeName = sanitized.isEmpty ? 'Bible Plan' : String.fromCharCodes(sanitized.runes.take(100));
    return path.setExtension(safeName, '.lxbp');
  }
}

extension _BiblePlanFilenameString on String {
  String get withInvalidFilenameCharactersReplaced => replaceAll(RegExp(r'[\\/:*?"<>|\x00-\x1F]'), '_');

  String get withoutTrailingFilenameDotsOrSpaces => replaceAll(RegExp(r'[. ]+$'), '');
}
