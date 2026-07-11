import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BibleLoadingError extends ConsumerWidget {
  final BibleTranslation translation;
  final Function() onRetry;

  final EdgeInsets padding;

  const BibleLoadingError({super.key, required this.translation, required this.onRetry, this.padding = const .all(16)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StyledListView.child(
      padding: padding,
      child: Column(
        spacing: 12,
        children: [
          StyledTile.message(
            leading: Symbols.error.toIcon(),
            title: 'Something went wrong'.toText(),
            subtitle: 'Make sure you are connected to the internet or try again later.'.toText(),
          ),
          if (translation != .bsb)
            StyledRectButton.secondary(
              label: 'Switch to BSB'.toText(),
              onPressed: () => ref.updateUser((user) => user.withTranslation(.bsb)),
            ),
          StyledRectButton.secondary(label: 'Try Again'.toText(), onPressed: onRetry),
        ],
      ),
    );
  }
}
