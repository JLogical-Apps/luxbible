import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/selection_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SelectionShortcut {
  annotate,
  copy;

  String title() => toSelectionAction().title();
  String description() => toSelectionAction().description();
  IconData get icon => toSelectionAction().icon;

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required Selection selection,
    required User user,
    required Bible bible,
    required Function() onDeselect,
  }) => toSelectionAction().onPressed(
    context,
    ref,
    selection: selection,
    bible: bible,
    user: user,
    onDeselect: onDeselect,
  );

  SelectionAction toSelectionAction() => switch (this) {
    annotate => SelectionAction.annotate,
    copy => SelectionAction.copy,
  };
}
