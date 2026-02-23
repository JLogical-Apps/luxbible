import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum SelectionAction {
  annotate,
  copy;

  String title() => switch (this) {
    annotate => 'Annotate',
    copy => 'Copy',
  };

  String description() => switch (this) {
    annotate => 'Annotate the selection.',
    copy => 'Copy the selection to your clipboard.',
  };

  Widget buildIcon() => switch (this) {
    annotate => Icon(Symbols.note_stack),
    copy => Icon(Symbols.copy_all),
  };

  bool get isNavigation => [annotate].contains(this);

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required Selection selection,
    required Bible bible,
    required Function() onDeselect,
  }) async {
    switch (this) {
      case annotate:
        final annotation = await AnnotationSheet.show(context, ref, region: selection, bible: bible, user: user);
        if (annotation != null) {
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case copy:
        onDeselect();
        context.showStyledSnackbar(messageText: 'Selection copied to clipboard.');
        await Clipboard.setData(ClipboardData(text: bible.getSelectionText(selection)));
    }
  }
}
