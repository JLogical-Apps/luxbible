import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';

class SwipePageView extends HookWidget {
  final PageController? controller;
  final int pageCount;

  final Function(int page)? onSwipe;
  final Function(int page)? onPageChanged;

  final List<Widget>? children;
  final Widget Function(BuildContext context, int index)? itemBuilder;

  const SwipePageView({
    super.key,
    this.controller,
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

    final pageController = controller ?? usePageController();

    return SwipeGestureDetector(
      index: () => pageController.page!.round(),
      maxIndex: pageCount,
      onSwipe: (newIndex) {
        pageController.animateToPage(newIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
        onSwipe?.call(newIndex);
      },
      child: children != null
          ? PageView(
              key: ValueKey(pageCount),
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              children: children,
            )
          : itemBuilder != null
          ? PageView.builder(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pageCount,
              onPageChanged: onPageChanged,
              itemBuilder: itemBuilder,
            )
          : null,
    );
  }
}
