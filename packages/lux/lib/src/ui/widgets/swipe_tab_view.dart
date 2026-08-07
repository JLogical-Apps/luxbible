import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

class SwipeTabView extends StatelessWidget {
  final TabController controller;

  final List<Widget> children;

  const SwipeTabView({super.key, required this.controller, required this.children});

  @override
  Widget build(BuildContext context) {
    return SwipeGestureDetector(
      index: () => controller.index,
      maxIndex: controller.length,
      onSwipe: (newIndex) =>
          controller.animateTo(newIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic),
      child: TabBarView(controller: controller, physics: NeverScrollableScrollPhysics(), children: children),
    );
  }
}
