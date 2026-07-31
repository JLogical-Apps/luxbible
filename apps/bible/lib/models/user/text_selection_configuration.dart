import 'package:bible/models/user/text_selection_shortcut.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_selection_configuration.freezed.dart';
part 'text_selection_configuration.g.dart';

@freezed
sealed class TextSelectionConfiguration with _$TextSelectionConfiguration {
  const TextSelectionConfiguration._();

  const factory TextSelectionConfiguration({
    @Default(TextSelectionShortcut.annotate) TextSelectionShortcut pinnedShortcut1,
    @Default(TextSelectionShortcut.search) TextSelectionShortcut pinnedShortcut2,
    @Default(TextSelectionShortcut.copy) TextSelectionShortcut pinnedShortcut3,
    @Default(TextSelectionShortcut.highlight) TextSelectionShortcut longPressShortcut,
    @Default(false) bool expandToAnnotation,
  }) = _TextSelectionConfiguration;

  factory TextSelectionConfiguration.fromJson(Map<String, dynamic> json) => _$TextSelectionConfigurationFromJson(json);

  List<TextSelectionShortcut> get pinnedShortcuts => [pinnedShortcut1, pinnedShortcut2, pinnedShortcut3];

  TextSelectionConfiguration withPinnedShortcut(int shortcutIndex, TextSelectionShortcut shortcut) => copyWith(
    pinnedShortcut1: shortcutIndex == 0 ? shortcut : pinnedShortcut1,
    pinnedShortcut2: shortcutIndex == 1 ? shortcut : pinnedShortcut2,
    pinnedShortcut3: shortcutIndex == 2 ? shortcut : pinnedShortcut3,
  );
}
