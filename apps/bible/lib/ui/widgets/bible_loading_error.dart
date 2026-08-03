import 'package:lux/lux.dart';
import 'package:lux/i18n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BibleLoadingError extends ConsumerWidget {
  final BibleTranslation translation;
  final Object? error;
  final Function() onRetry;

  final EdgeInsets padding;

  const BibleLoadingError({
    super.key,
    required this.translation,
    required this.onRetry,
    this.error,
    this.padding = const .all(16),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final (:title, :subtitle) = switch (error) {
      DioException(response: final response?)
          when response.statusCode == 401 && translation.source is ApiBibleTranslationSource =>
        (title: t.errors.deviceVerificationFailed, subtitle: t.errors.deviceVerificationDescription),
      _ => (title: t.errors.generic, subtitle: t.errors.connection),
    };

    return StyledListView.child(
      padding: padding,
      child: Column(
        spacing: 12,
        children: [
          StyledTile.message(leading: Symbols.error.toIcon(), title: title.toText(), subtitle: subtitle.toText()),
          if (translation != user.studyTranslation)
            StyledRectButton.secondary(
              label: t.common.switchTo(translation: user.studyTranslation.title()).toText(),
              onPressed: () => ref.updateUser((user) => user.withTranslation(user.studyTranslation)),
            ),
          StyledRectButton.secondary(label: t.common.tryAgain.toText(), onPressed: onRetry),
        ],
      ),
    );
  }
}
