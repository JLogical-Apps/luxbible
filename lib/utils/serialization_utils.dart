import 'package:freezed_annotation/freezed_annotation.dart';

const jsonIgnore = JsonKey(includeToJson: false, includeFromJson: false);
const nullUnknownEnum = JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue);
