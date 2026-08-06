import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({@Default(ThemeMode.system) ThemeMode theme, @Default([]) List<VerseSelection> passages}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
