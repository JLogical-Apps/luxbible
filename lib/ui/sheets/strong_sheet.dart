import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
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
        title: strong.languageText.toText(),
        children: [
          StyledSection(
            title: 'Info'.toText(),
            padding: EdgeInsets.only(top: 24),
            children: [
              StyledListItem(title: 'ID'.toText(), subtitle: strongId.toText()),
              StyledListItem(title: 'Pronunciation'.toText(), subtitle: strong.pronunciation.toText()),
              StyledListItem(title: 'Transliteration'.toText(), subtitle: strong.transliteration.toText()),
              StyledListItem(title: 'Definition'.toText(), subtitle: strong.definition.toText()),
            ],
          ),
          if (seeMoreStrongs.isNotEmpty)
            StyledSection(
              title: 'See More'.toText(),
              padding: EdgeInsets.only(top: 24),
              children: seeMoreStrongs
                  .map(
                    (strong) => StyledListItem.navigation(
                      title: strong.id.toText(),
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
