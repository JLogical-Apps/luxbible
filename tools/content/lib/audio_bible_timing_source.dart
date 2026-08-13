import 'package:lux/lux_core.dart';

extension AudioBibleTimingBookSourceExtension on BookType {
  String get audioBibleTimingSourceName => switch (this) {
    .samuel1 => '1samuel',
    .samuel2 => '2samuel',
    .kings1 => '1kings',
    .kings2 => '2kings',
    .chronicles1 => '1chronicles',
    .chronicles2 => '2chronicles',
    .corinthians1 => '1corinthians',
    .corinthians2 => '2corinthians',
    .thessalonians1 => '1thessalonians',
    .thessalonians2 => '2thessalonians',
    .timothy1 => '1timothy',
    .timothy2 => '2timothy',
    .peter1 => '1peter',
    .peter2 => '2peter',
    .john1 => '1john',
    .john2 => '2john',
    .john3 => '3john',
    .songOfSolomon => 'songofsolomon',
    _ => name,
  };
}
