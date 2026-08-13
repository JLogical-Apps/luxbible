import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_bible_configuration.freezed.dart';
part 'audio_bible_configuration.g.dart';

@freezed
sealed class AudioBibleConfiguration with _$AudioBibleConfiguration {
  const AudioBibleConfiguration._();

  const factory AudioBibleConfiguration({
    @Default(false) bool isOpen,
    @Default(1) double speed,
    @Default(true) bool followAlong,
    DateTime? endTime,
  }) = _AudioBibleConfiguration;

  factory AudioBibleConfiguration.fromJson(Map<String, dynamic> json) => _$AudioBibleConfigurationFromJson(json);
}
