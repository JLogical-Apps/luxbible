import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledTabBar extends HookWidget {
  final TabController tabController;
  final List<Widget> tabTitles;

  final bool scrollable;

  const StyledTabBar({super.key, required this.tabController, required this.tabTitles, required this.scrollable});
  const StyledTabBar.fill({super.key, required this.tabController, required this.tabTitles}) : scrollable = false;
  const StyledTabBar.scrollable({super.key, required this.tabController, required this.tabTitles}) : scrollable = true;

  @override
  Widget build(BuildContext context) {
    final keys = List.generate(tabTitles.length, (_) => GlobalKey());

    void ensureTabVisible({Duration? duration}) {
      if (!scrollable) {
        return;
      }

      final tabContext = keys.elementAtOrNull(tabController.index)?.currentContext;
      if (tabContext != null) {
        Scrollable.ensureVisible(
          tabContext,
          duration: duration ?? Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          alignment: 0.5,
        );
      }
    }

    usePostFrameEffect(() => ensureTabVisible(duration: Duration.zero));
    useOnListenableChange(tabController, () => ensureTabVisible());

    final tabBar = TabBar(
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
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: context.textStyle.labelMd,
      unselectedLabelStyle: context.textStyle.labelMd,
      indicatorWeight: 4,
      tabs: tabTitles.mapIndexed((i, title) => Tab(key: keys[i], height: 52, child: title)).toList(),
    );

    return SizedBox(
      width: double.infinity,
      height: 57,
      child: Stack(
        children: [
          Positioned.fill(top: null, child: Container(height: 4, color: context.colors.borderOpaque)),
          scrollable ? SingleChildScrollView(scrollDirection: .horizontal, child: tabBar) : tabBar,
        ],
      ),
    );
  }
}
