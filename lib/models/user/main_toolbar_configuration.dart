import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_toolbar_configuration.freezed.dart';
part 'main_toolbar_configuration.g.dart';

@freezed
sealed class MainToolbarConfiguration with _$MainToolbarConfiguration {
  const MainToolbarConfiguration._();

  const factory MainToolbarConfiguration({
    @Default(MainToolbarShortcut.bookmark) MainToolbarShortcut pinnedShortcut1,
    @Default(MainToolbarShortcut.search) MainToolbarShortcut pinnedShortcut2,
    @Default(MainToolbarShortcut.studyPanel) MainToolbarShortcut longPressShortcut,
    @Default(false) bool pinToBottom,
  }) = _MainToolbarConfiguration;

  factory MainToolbarConfiguration.fromJson(Map<String, dynamic> json) => _$MainToolbarConfigurationFromJson(json);

  List<MainToolbarShortcut> get pinnedShortcuts => [pinnedShortcut1, pinnedShortcut2];

  MainToolbarConfiguration withPinnedShortcut(int shortcutIndex, MainToolbarShortcut shortcut) => copyWith(
    pinnedShortcut1: shortcutIndex == 0 ? shortcut : pinnedShortcut1,
    pinnedShortcut2: shortcutIndex == 1 ? shortcut : pinnedShortcut2,
  );
}
