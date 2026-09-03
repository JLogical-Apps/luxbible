import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class InterlinearDirectionSheet {
  static Future<InterlinearDirection?> show(BuildContext context, {InterlinearDirection? initialDirection}) =>
      context.showStyledSheet(
        (context, _) => StyledSelectionSheet(
          title: t.interlinearUi.direction.toText(),
          initialOption: initialDirection,
          options: InterlinearDirection.values,
          optionMapper: (option) => StyledSelectOption(
            title: option.title().toText(),
            subtitle: option.description().toText(),
            leading: option.icon.toIcon(),
          ),
        ),
      );
}
