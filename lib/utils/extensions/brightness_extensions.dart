import 'package:flutter/material.dart';

extension BrightnessExtensions on Brightness {
  T when<T>({required T light, required T dark}) => switch (this) {
    Brightness.light => light,
    Brightness.dark => dark,
  };

  Brightness get inverted => when(light: Brightness.dark, dark: Brightness.light);
}
