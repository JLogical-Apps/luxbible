import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StrongSheet {
  static Future<void> showWithContext(BuildContext context, WidgetRef ref, {required String strongId}) async {
    final strongs = ref.watch(strongsProvider);
    final strong = strongs[strongId];
    if (strong == null) {
      return;
    }

    final seeMoreStrongs = strong.glossary.map((glossary) => strongs[glossary]).nonNulls.toList();

    await context.showStyledSheetWithContext(
      breadcrumbText: strong.languageText,
      (context) => StyledSheet(
        titleText: strong.languageText,
        children: [
          StyledSection(
            titleText: 'Info',
            padding: EdgeInsets.only(top: 24),
            children: [
              StyledListItem(titleText: 'ID', subtitleText: strongId),
              StyledListItem(titleText: 'Pronunciation', subtitleText: strong.pronunciation),
              StyledListItem(titleText: 'Transliteration', subtitleText: strong.transliteration),
              StyledListItem(titleText: 'Definition', subtitleText: strong.definition),
            ],
          ),
          if (seeMoreStrongs.isNotEmpty)
            StyledSection(
              titleText: 'See More',
              padding: EdgeInsets.only(top: 24),
              children: seeMoreStrongs
                  .map(
                    (strong) => StyledListItem.navigation(
                      titleText: strong.id,
                      subtitle: Text(
                        '${strong.languageText}: ${strong.definition}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        context.pop();
                        StrongSheet.showWithContext(context, ref, strongId: strong.id);
                      },
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
