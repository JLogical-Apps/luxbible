import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'audio_bible_configuration.freezed.dart';
part 'audio_bible_configuration.g.dart';

@freezed
sealed class AudioBibleConfiguration with _$AudioBibleConfiguration {
  const AudioBibleConfiguration._();

  const factory AudioBibleConfiguration({@Default(false) bool isOpen, @Default(1) double speed, DateTime? endTime}) =
      _AudioBibleConfiguration;

  factory AudioBibleConfiguration.fromJson(Map<String, dynamic> json) => _$AudioBibleConfigurationFromJson(json);

  static List<double> audioBibleSpeeds = [0.7, 1, 1.2, 1.5, 1.7, 2];

  double get nextSpeed => audioBibleSpeeds.loopedElementAt(audioBibleSpeeds.indexOf(speed) + 1);
}
