import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux.dart';

part 'copy_configuration.freezed.dart';
part 'copy_configuration.g.dart';

@freezed
sealed class CopyConfiguration with _$CopyConfiguration {
  const CopyConfiguration._();

  const factory CopyConfiguration({@Default(false) bool includesReference, @Default(false) bool includesTranslation}) =
      _CopyConfiguration;

  factory CopyConfiguration.fromJson(Map<String, dynamic> json) => _$CopyConfigurationFromJson(json);

  bool isReferenceIncluded(BibleTranslation translation) => translation.isOnline || includesReference;

  bool isTranslationIncluded(BibleTranslation translation) =>
      isReferenceIncluded(translation) && (translation.isOnline || includesTranslation);
}
