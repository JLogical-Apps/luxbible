import 'package:bible/models/passage.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sliver/styled_sliver_list.dart';
import 'package:bible/style/widgets/sliver/styled_sticky_sliver_header.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/style/widgets/styled_tag.dart';
import 'package:bible/ui/pages/strong_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InterlinearPage extends ConsumerWidget {
  final Passage passage;

  const InterlinearPage({super.key, required this.passage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    final strongs = ref.watch(strongsProvider);
    final user = ref.watch(userProvider);
    final bible = user.getBible(bibles);

    return StyledPage(
      titleText: 'Interlinear ${passage.format()}',
      backgroundColor: context.colors.surfacePrimary,
      body: StyledScrollbar(
        child: CustomScrollView(
          slivers: passage.sortedReferences
              .map(
                (reference) => StyledSliverStickyHeader(
                  titleText: reference.format(),
                  sliver: StyledSliverList(
                    children: bible
                        .getVerseByReference(reference)
                        .fragments
                        .mapToMap((fragment) => MapEntry(fragment, fragment.strongIds.firstOrNull))
                        .withoutNullValues
                        .mapToIterable(
                          (fragment, strongId) => StyledListItem.navigation(
                            titleText: fragment.text.trim(),
                            subtitle: Row(
                              spacing: 4,
                              children: [
                                StyledTag(text: strongId),
                                if (strongs[strongId] case final strong?) Text(strong.languageText),
                              ],
                            ),
                            onPressed: () => context.push(StrongPage(strongId: strongId)),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
