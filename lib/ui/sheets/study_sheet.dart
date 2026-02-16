import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudySheet {
  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required ReferencesRegion region,
    required Bible bible,
  }) => context.showStyledSheet(
    StyledSheet.list(
      titleText: 'Study ${region.format()}',
      children: StudyAction.values
          .map(
            (action) => StyledListItem.navigation(
              titleText: action.title(),
              subtitleText: action.description(region: region),
              leadingIcon: action.icon,
              onPressed: () {
                context.pop();
                action.onPressed(context, ref, region: region, bible: bible);
              },
            ),
          )
          .toList(),
    ),
  );
}
