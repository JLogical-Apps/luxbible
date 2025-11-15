import 'package:bible/models/passage.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';

class ComparePage extends ConsumerWidget {
  final Passage passage;

  const ComparePage({super.key, required this.passage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    return StyledPage(
      titleText: 'Compare ${passage.format()}',
      body: StyledScrollbar(
        child: ListView(
          children: bibles
              .map<Widget>(
                (bible) => StyledSection(
                  titleText: bible.translation.title(),
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: PassageBuilder(passage: passage, bible: bible),
                ),
              )
              .intersperse(StyledDivider(height: 2))
              .toList(),
        ),
      ),
    );
  }
}
