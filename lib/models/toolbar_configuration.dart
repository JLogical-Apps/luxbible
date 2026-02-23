import 'package:bible/models/toolbar_shortcut.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toolbar_configuration.freezed.dart';
part 'toolbar_configuration.g.dart';

@freezed
sealed class ToolbarConfiguration with _$ToolbarConfiguration {
  const ToolbarConfiguration._();

  const factory ToolbarConfiguration({
    @Default(ToolbarShortcut.bookmark) ToolbarShortcut pinnedShortcut1,
    @Default(ToolbarShortcut.interlinear) ToolbarShortcut pinnedShortcut2,
  }) = _ToolbarConfiguration;

  factory ToolbarConfiguration.fromJson(Map<String, dynamic> json) => _$ToolbarConfigurationFromJson(json);

  List<ToolbarShortcut> get pinnedShortcuts => [pinnedShortcut1, pinnedShortcut2];

  ToolbarConfiguration withPinnedShortcut(int shortcutIndex, ToolbarShortcut shortcut) => copyWith(
    pinnedShortcut1: shortcutIndex == 0 ? shortcut : pinnedShortcut1,
    pinnedShortcut2: shortcutIndex == 1 ? shortcut : pinnedShortcut2,
  );
}
