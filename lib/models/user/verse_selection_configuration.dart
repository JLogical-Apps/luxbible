import 'package:bible/models/user/verse_selection_shortcut.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verse_selection_configuration.freezed.dart';
part 'verse_selection_configuration.g.dart';

@freezed
sealed class VerseSelectionConfiguration with _$VerseSelectionConfiguration {
  const VerseSelectionConfiguration._();

  const factory VerseSelectionConfiguration({
    @Default(VerseSelectionShortcut.annotate) VerseSelectionShortcut pinnedShortcut1,
    @Default(VerseSelectionShortcut.commentary) VerseSelectionShortcut pinnedShortcut2,
    @Default(VerseSelectionShortcut.interlinear) VerseSelectionShortcut pinnedShortcut3,
    @Default(VerseSelectionShortcut.highlight) VerseSelectionShortcut longPressShortcut,
    @Default(false) bool expandToAnnotation,
    @Default(true) bool rangeSelection,
  }) = _VerseSelectionConfiguration;

  factory VerseSelectionConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VerseSelectionConfigurationFromJson(json);

  List<VerseSelectionShortcut> get pinnedShortcuts => [pinnedShortcut1, pinnedShortcut2, pinnedShortcut3];

  VerseSelectionConfiguration withPinnedShortcut(int shortcutIndex, VerseSelectionShortcut shortcut) => copyWith(
    pinnedShortcut1: shortcutIndex == 0 ? shortcut : pinnedShortcut1,
    pinnedShortcut2: shortcutIndex == 1 ? shortcut : pinnedShortcut2,
    pinnedShortcut3: shortcutIndex == 2 ? shortcut : pinnedShortcut3,
  );
}
