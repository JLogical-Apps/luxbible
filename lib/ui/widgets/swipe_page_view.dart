import 'package:bible/ui/widgets/swipe_gesture_detector.dart';
import 'package:flutter/material.dart';

class SwipePageView extends StatelessWidget {
  final PageController controller;
  final int pageCount;

  final Function(int page)? onSwipe;
  final Function(int page)? onPageChanged;

  final List<Widget>? children;
  final Widget Function(BuildContext context, int index)? itemBuilder;

  const SwipePageView({
    super.key,
    required this.controller,
    required this.pageCount,
    required this.children,
    this.onSwipe,
    this.onPageChanged,
  }) : itemBuilder = null;

  const SwipePageView.builder({
    super.key,
    required this.controller,
    required this.pageCount,
    required this.itemBuilder,
    this.onSwipe,
    this.onPageChanged,
  }) : children = null;

  @override
  Widget build(BuildContext context) {
    final children = this.children;
    final itemBuilder = this.itemBuilder;

    return SwipeGestureDetector(
      index: controller.page!.round(),
      maxIndex: pageCount,
      onSwipe: (newIndex) =>
          controller.animateToPage(newIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic),
      child: children != null
          ? PageView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              children: children,
            )
          : itemBuilder != null
          ? PageView.builder(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pageCount,
              onPageChanged: onPageChanged,
              itemBuilder: itemBuilder,
            )
          : null,
    );
  }
}
