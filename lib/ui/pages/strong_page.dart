import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StrongPage extends ConsumerWidget {
  final String strongId;

  const StrongPage({super.key, required this.strongId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strongs = ref.watch(strongsProvider);
    final strong = strongs[strongId];

    if (strong == null) {
      return StyledPage(
        body: Center(child: Text('No info found for $strongId', style: context.textStyle.headingXs)),
      );
    }

    return StyledPage(
      titleText: strong.languageText,
      body: StyledScrollbar(
        child: ListView(
          children: [
            StyledSection(
              titleText: 'Info',
              child: StyledCard.list(
                children: [
                  StyledListItem(titleText: 'ID', subtitleText: strongId),
                  StyledListItem(titleText: 'Pronunciation', subtitleText: strong.pronunciation),
                  StyledListItem(titleText: 'Transliteration', subtitleText: strong.transliteration),
                  StyledListItem(titleText: 'Definition', subtitleText: strong.definition),
                ],
              ),
            ),
            if (strong.glossary.isNotEmpty)
              StyledSection(
                titleText: 'See More',
                child: StyledCard.list(
                  children: strong.glossary
                      .map((glossary) => strongs[glossary])
                      .nonNulls
                      .map(
                        (strong) => StyledListItem.navigation(
                          titleText: strong.id,
                          subtitle: Text(
                            '${strong.languageText}: ${strong.definition}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () => context.push(StrongPage(strongId: strong.id)),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
