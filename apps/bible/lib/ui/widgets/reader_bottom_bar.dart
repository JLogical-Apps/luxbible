import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class ReaderBottomBar extends StatelessWidget {
  final bool isToolbarVisible;
  final bool hasStudyPanels;
  final bool isSideLayout;

  final Widget toolbar;
  final Widget? selectionToolbar;

  const ReaderBottomBar({
    super.key,
    required this.isToolbarVisible,
    required this.hasStudyPanels,
    required this.isSideLayout,
    required this.toolbar,
    required this.selectionToolbar,
  });

  @override
  Widget build(BuildContext context) {
    final selectionToolbar = this.selectionToolbar;

    // Study panels below the bar already sit over the bottom safe area.
    final targetInsets = !hasStudyPanels || isSideLayout ? MediaQuery.viewPaddingOf(context) : EdgeInsets.zero;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      tween: Tween(begin: targetInsets, end: targetInsets),
      builder: (context, insets, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(padding: insets, viewPadding: insets, viewInsets: insets),
        child: child!,
      ),
      child: Stack(
        clipBehavior: .none,
        children: [
          Builder(
            builder: (context) => AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              bottom: isToolbarVisible
                  ? hasStudyPanels
                        ? 4
                        : 0
                  : -24,
              right: 0,
              left: 0,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                offset: isToolbarVisible ? Offset.zero : Offset(0, 1.2),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(boxShadow: [StyledShadow.down(context)]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16) + .only(bottom: MediaQuery.paddingOf(context).bottom + 16),
                  child: toolbar,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: ColoredBox(
              color: context.colors.surfacePrimary,
              child: AnimatedGrow(
                child: selectionToolbar != null
                    ? Builder(
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            boxShadow: [StyledShadow.up(context)],
                            color: context.colors.surfacePrimary,
                          ),
                          padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                          child: selectionToolbar,
                        ),
                      )
                    : SizedBox.shrink(key: ValueKey('empty')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
