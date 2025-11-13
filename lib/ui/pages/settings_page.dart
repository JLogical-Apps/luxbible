import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledPage(
      titleText: 'Settings',
      body: StyledScrollbar(
        child: ListView(
          children: [
            StyledSection(
              titleText: 'Features',
              child: StyledCard.list(
                children: [
                  StyledListItem.navigation(
                    titleText: 'Toolbar Actions',
                    subtitleText: 'Configure the actions on your toolbar.',
                    leadingIcon: Symbols.toolbar,
                    onPressed: () {},
                  ),
                  StyledListItem.navigation(
                    titleText: 'Passage Actions',
                    subtitleText: 'Configure the actions when you select a passage.',
                    leadingIcon: Symbols.article,
                    onPressed: () {},
                  ),
                  StyledListItem.navigation(
                    titleText: 'Search',
                    subtitleText: 'Configure your search experience.',
                    leadingIcon: Symbols.search,
                    onPressed: () {},
                  ),
                  StyledListItem.navigation(
                    titleText: 'Highlights',
                    subtitleText: 'Customize highlight tags.',
                    leadingIcon: Symbols.format_ink_highlighter,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
