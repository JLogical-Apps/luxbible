import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanAnnotationsListItem extends StatelessWidget {
  final Function() onPressed;

  const BiblePlanAnnotationsListItem({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => StyledListItem(
    leading: Symbols.note_stack.toIcon(),
    title: t.biblePlans.viewAllAnnotations.toText(),
    subtitle: t.biblePlans.viewAllAnnotationsDescription.toText(),
    onPressed: onPressed,
  );
}

class BiblePlanHistoryListItem extends StatelessWidget {
  final Function() onPressed;

  const BiblePlanHistoryListItem({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) => StyledListItem(
    leading: Symbols.history.toIcon(),
    title: t.biblePlans.history.toText(),
    subtitle: t.biblePlans.historyDescription.toText(),
    onPressed: onPressed,
  );
}
