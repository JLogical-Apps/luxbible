import 'package:flutter/material.dart';

class SwipeTabView extends StatelessWidget {
  final TabController controller;

  final List<Widget> children;

  const SwipeTabView({super.key, required this.controller, required this.children});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final delta = details.velocity.pixelsPerSecond;
        const sensitivity = 8;

        final currentTab = controller.index.round();
        final newTab = delta.dx > sensitivity
            ? currentTab - 1
            : delta.dx < -sensitivity
            ? currentTab + 1
            : null;

        if (newTab == null || newTab < 0 || newTab >= controller.length) {
          return;
        }

        controller.animateTo(newTab, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
      },
      child: TabBarView(controller: controller, physics: NeverScrollableScrollPhysics(), children: children),
    );
  }
}
