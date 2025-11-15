import 'package:bible/models/passage.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sliver/styled_sliver_list.dart';
import 'package:bible/style/widgets/sliver/styled_sticky_sliver_header.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentariesPage extends ConsumerWidget {
  final Passage passage;

  const CommentariesPage({super.key, required this.passage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentaries = ref.watch(commentariesProvider);

    return StyledPage(
      titleText: 'Commentaries of ${passage.format()}',
      backgroundColor: context.colors.surfacePrimary,
      body: StyledScrollbar(
        child: CustomScrollView(
          slivers: commentaries
              .mapToMap((commentary) => MapEntry(commentary, commentary.getNotesFor(passage)))
              .where((commentary, notes) => notes.isNotEmpty)
              .mapToIterable(
                (commentary, notes) => StyledSliverStickyHeader(
                  titleText: commentary.name,
                  sliver: StyledSliverList(
                    children: notes
                        .mapToIterable(
                          (passage, note) => StyledListItem(titleText: passage.format(), subtitleText: note),
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
