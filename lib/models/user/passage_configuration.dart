import 'package:bible/models/user/passage_shortcut.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'passage_configuration.freezed.dart';
part 'passage_configuration.g.dart';

@freezed
sealed class PassageConfiguration with _$PassageConfiguration {
  const PassageConfiguration._();

  const factory PassageConfiguration({
    @Default(PassageShortcut.annotate) PassageShortcut pinnedShortcut1,
    @Default(PassageShortcut.commentary) PassageShortcut pinnedShortcut2,
    @Default(PassageShortcut.interlinear) PassageShortcut pinnedShortcut3,
  }) = _PassageConfiguration;

  factory PassageConfiguration.fromJson(Map<String, dynamic> json) => _$PassageConfigurationFromJson(json);

  List<PassageShortcut> get pinnedShortcuts => [pinnedShortcut1, pinnedShortcut2, pinnedShortcut3];

  PassageConfiguration withPinnedShortcut(int shortcutIndex, PassageShortcut shortcut) => copyWith(
    pinnedShortcut1: shortcutIndex == 0 ? shortcut : pinnedShortcut1,
    pinnedShortcut2: shortcutIndex == 1 ? shortcut : pinnedShortcut2,
    pinnedShortcut3: shortcutIndex == 2 ? shortcut : pinnedShortcut3,
  );
}
