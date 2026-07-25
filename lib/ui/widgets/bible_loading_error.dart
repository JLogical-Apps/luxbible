import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

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
        (
          title: 'Device verification failed',
          subtitle:
              'Access to this online Bible requires a valid device and legitimate installation of Lux. '
              'Make sure you installed Lux from an official app store, then try again.',
        ),
      _ => (title: 'Something went wrong', subtitle: 'Check your internet connection or try again later.'),
    };

    return StyledListView.child(
      padding: padding,
      child: Column(
        spacing: 12,
        children: [
          StyledTile.message(leading: Symbols.error.toIcon(), title: title.toText(), subtitle: subtitle.toText()),
          if (translation != user.studyTranslation)
            StyledRectButton.secondary(
              label: 'Switch to ${user.studyTranslation.title()}'.toText(),
              onPressed: () => ref.updateUser((user) => user.withTranslation(user.studyTranslation)),
            ),
          StyledRectButton.secondary(label: 'Try Again'.toText(), onPressed: onRetry),
        ],
      ),
    );
  }
}
