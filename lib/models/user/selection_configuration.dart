import 'package:bible/models/user/selection_shortcut.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_configuration.freezed.dart';
part 'selection_configuration.g.dart';

@freezed
sealed class SelectionConfiguration with _$SelectionConfiguration {
  const SelectionConfiguration._();

  const factory SelectionConfiguration({
    @Default(SelectionShortcut.annotate) SelectionShortcut pinnedShortcut1,
    @Default(SelectionShortcut.highlight) SelectionShortcut pinnedShortcut2,
    @Default(SelectionShortcut.copy) SelectionShortcut pinnedShortcut3,
  }) = _SelectionConfiguration;

  factory SelectionConfiguration.fromJson(Map<String, dynamic> json) => _$SelectionConfigurationFromJson(json);

  List<SelectionShortcut> get pinnedShortcuts => [pinnedShortcut1, pinnedShortcut2, pinnedShortcut3];

  SelectionConfiguration withPinnedShortcut(int shortcutIndex, SelectionShortcut shortcut) => copyWith(
    pinnedShortcut1: shortcutIndex == 0 ? shortcut : pinnedShortcut1,
    pinnedShortcut2: shortcutIndex == 1 ? shortcut : pinnedShortcut2,
    pinnedShortcut3: shortcutIndex == 2 ? shortcut : pinnedShortcut3,
  );
}
