import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux.dart';

part 'navigation_configuration.freezed.dart';
part 'navigation_configuration.g.dart';

@freezed
sealed class NavigationConfiguration with _$NavigationConfiguration {
  const factory NavigationConfiguration({
    @Default(NavigationLayout.list) NavigationLayout layout,
    @Default(true) bool showsRecents,
    @Default(true) bool opensKeyboard,
  }) = _NavigationConfiguration;

  factory NavigationConfiguration.fromJson(Map<String, dynamic> json) => _$NavigationConfigurationFromJson(json);
}
