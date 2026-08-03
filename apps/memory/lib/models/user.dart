import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({@Default(ThemeMode.system) ThemeMode theme}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
