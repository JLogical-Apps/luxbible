import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BibleLoadingError extends StatelessWidget {
  final BibleTranslation translation;

  final Object? error;
  final Function() onRetry;

  final bool suggestTranslationSwap;
  final BibleTranslation? fallbackTranslation;
  final Function()? onSwitchToFallback;

  final bool shrinkWrap;
  final EdgeInsets padding;

  const BibleLoadingError({
    super.key,
    required this.translation,
    required this.onRetry,
    this.error,
    this.suggestTranslationSwap = true,
    this.fallbackTranslation,
    this.onSwitchToFallback,
    this.shrinkWrap = false,
    this.padding = .zero,
  });

  @override
  Widget build(BuildContext context) {
    final (:title, :subtitle) = switch (error) {
      DioException(response: final response?)
          when response.statusCode == 401 && translation.source is ApiBibleTranslationSource =>
        (title: t.errors.deviceVerificationFailed, subtitle: t.errors.deviceVerificationDescription),
      _ => (title: t.errors.generic, subtitle: t.errors.connection),
    };

    final fallbackTranslation = this.fallbackTranslation;
    final onSwitchToFallback = this.onSwitchToFallback;

    return StyledListView.child(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        spacing: 12,
        children: [
          StyledTile.message(leading: Symbols.error.toIcon(), title: title.toText(), subtitle: subtitle.toText()),
          if (suggestTranslationSwap &&
              fallbackTranslation != null &&
              fallbackTranslation != translation &&
              onSwitchToFallback != null)
            StyledRectButton.secondary(
              label: t.common.switchTo(translation: fallbackTranslation.title()).toText(),
              onPressed: onSwitchToFallback,
            ),
          StyledRectButton.secondary(label: t.common.tryAgain.toText(), onPressed: onRetry),
        ],
      ),
    );
  }
}
