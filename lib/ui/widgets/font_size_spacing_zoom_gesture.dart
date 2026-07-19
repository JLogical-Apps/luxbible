import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FontSizeSpacingZoomGesture extends HookWidget {
  final BibleLanguage language;
  final Widget child;

  const FontSizeSpacingZoomGesture({super.key, required this.language, required this.child});

  @override
  Widget build(BuildContext context) {
    final lastScale = useRef(1.0);
    return GestureDetector(
      onScaleStart: (_) => lastScale.value = 1,
      onScaleUpdate: (details) {
        final user = ref.read(userProvider);
        final currentValue = user.themeLayout.getFontSizeSpacingFor(language);

        final newValue = switch (details.scale) {
          final value when value >= lastScale.value * 1.1 => currentValue.next,
          final value when value <= lastScale.value * 0.9 => currentValue.previous,
          _ => null,
        };
        if (newValue == null) return;

        lastScale.value = details.scale;
        ref.updateUser(
          (user) => switch (language) {
            .greek => user.copyWith.themeLayout(greekFontSizeSpacing: newValue),
            .hebrew => user.copyWith.themeLayout(hebrewFontSizeSpacing: newValue),
            _ => user.copyWith.themeLayout(fontSizeSpacing: newValue),
          },
        );
      },
      child: child,
    );
  }
}
