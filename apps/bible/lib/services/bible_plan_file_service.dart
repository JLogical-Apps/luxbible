import 'dart:convert';
import 'dart:typed_data';

import 'package:bible/models/bible_plan.dart';
import 'package:bible/utils/filename_utils.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

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

class BiblePlanFile {
  final BiblePlan plan;
  final List<BiblePlanDayProgress>? progress;
  final DateTime? targetDate;

  const BiblePlanFile({required this.plan, this.progress, this.targetDate});

  factory BiblePlanFile.fromJson(Map<String, dynamic> json) {
    final plan = BiblePlan.fromJson(json);
    final progress = (json['days'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .mapIndexed((dayIndex, dayJson) => getDayProgress(dayJson, day: plan.days[dayIndex]))
        .toList();
    return BiblePlanFile(
      plan: plan,
      progress: progress.any((day) => day.hasProgress) ? progress : null,
      targetDate: (json['targetDate'] as String?)?.mapIfNonNull(decodeIsoDate),
    );
  }

  // Completed passages outside the day are dropped, and a day whose passages are all read counts as complete.
  static BiblePlanDayProgress getDayProgress(Map<String, dynamic> dayJson, {required BiblePlanDay day}) {
    if (dayJson['completed'] as bool? ?? false) return .complete();

    final completedPassages = ChapterPassage.setFromJson(dayJson['completedPassages'] as List<dynamic>? ?? []);

    return BiblePlanDayProgress.incomplete().withPassagesCompleted(
      day: day,
      passages: day.passages.where(completedPassages.has),
    );
  }

  static Map<String, dynamic> getDayProgressJson(BiblePlanDayProgress progress, {required BiblePlanDay day}) =>
      switch (progress) {
        CompleteBiblePlanDayProgress() => {'completed': true},
        IncompleteBiblePlanDayProgress(:final completedPassages) when completedPassages.isNotEmpty => {
          'completedPassages': day.passages.where(completedPassages.has).map((passage) => passage.toJson()).toList(),
        },
        IncompleteBiblePlanDayProgress() => {},
      };

  Map<String, dynamic> toJson() => {
    ...plan.toJson(),
    'days': plan.days
        .mapIndexed(
          (dayIndex, day) => {
            ...day.toJson(),
            if (progress?.elementAtOrNull(dayIndex) case final dayProgress?)
              ...getDayProgressJson(dayProgress, day: day),
          },
        )
        .toList(),
    if (targetDate case final targetDate?) 'targetDate': encodeIsoDate(targetDate),
  };
}

class BiblePlanFileImport {
  final BiblePlanFile? file;
  final BiblePlanFileError? error;

  const BiblePlanFileImport.success(BiblePlanFile this.file) : error = null;
  const BiblePlanFileImport.failure(BiblePlanFileError this.error) : file = null;

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

  static BiblePlanFile decode(String contents) {
    final Object? json;
    try {
      json = jsonDecode(contents);
    } on FormatException {
      throw BiblePlanFileException(.malformedJson);
    }

    final BiblePlanFile file;
    try {
      file = BiblePlanFile.fromJson(json as Map<String, dynamic>);
    } catch (_) {
      throw BiblePlanFileException(.invalidStructure);
    }

    if (file.plan.validationError case final error?) {
      throw BiblePlanFileException(switch (error) {
        .nameRequired => .nameRequired,
        .invalidDayCount => .invalidDayCount,
        .readingRequired => .readingRequired,
        .invalidPassage => .invalidPassage,
        .duplicatePassage => .duplicatePassage,
      });
    }
    return file;
  }

  static String encode(BiblePlanFile file) => jsonEncode(file.toJson());

  static Uint8List getBytes(BiblePlanFile file) => Uint8List.fromList(utf8.encode(encode(file)));

  static String getFilename(String displayName) =>
      getSafeFilename(displayName, extension: '.lxbp', fallback: 'Bible Plan');
}
