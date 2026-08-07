import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:style/src/style_context_extensions.dart';

class StyledTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabTitles;

  final bool scrollable;

  const StyledTabBar({super.key, required this.tabController, required this.tabTitles, required this.scrollable});
  const StyledTabBar.fill({super.key, required this.tabController, required this.tabTitles}) : scrollable = false;
  const StyledTabBar.scrollable({super.key, required this.tabController, required this.tabTitles}) : scrollable = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 57,
      child: Stack(
        children: [
          Positioned.fill(top: null, child: Container(height: 4, color: context.colors.borderOpaque)),
          TabBar(
            controller: tabController,
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) => states.contains(WidgetState.focused) ? null : Colors.transparent,
            ),
            dividerColor: context.colors.borderOpaque,
            dividerHeight: 4,
            tabAlignment: scrollable ? TabAlignment.start : TabAlignment.fill,
            isScrollable: scrollable,
            labelPadding: EdgeInsets.symmetric(horizontal: scrollable ? 16 : 7),
            indicatorColor: context.colors.contentPrimary,
            indicatorSize: .tab,
            labelStyle: context.textStyle.labelMd,
            unselectedLabelStyle: context.textStyle.labelMd,
            indicatorWeight: 4,
            tabs: tabTitles.mapIndexed((i, title) => Tab(height: 52, child: title)).toList(),
          ),
        ],
      ),
    );
  }
}
