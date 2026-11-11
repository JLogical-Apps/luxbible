import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/widgets/sheet/styled_sheet_navigation_context.dart';
import 'package:style/src/widgets/sheet/styled_sheet_observer.dart';

class SheetTransition {
  final List<SheetNavigationBreadcrumb> fromBreadcrumbs;
  final SheetNavigationBreadcrumb to;
  final bool isForward;

  SheetTransition({required this.fromBreadcrumbs, required this.to, required this.isForward});

  SheetNavigationBreadcrumb get from => fromBreadcrumbs.last;
}

class StyledSheetNavigator extends HookWidget {
  final SheetNavigation navigation;

  const StyledSheetNavigator({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    final breadcrumbs = useValueListenable(navigation);
    final previousBreadcrumbsRef = useRef(breadcrumbs);
    final animationController = useAnimationController(duration: Duration(milliseconds: 350), initialValue: 1);
    final transitionState = useState<SheetTransition?>(null);
    final transition = transitionState.value;
    final isSwipingRef = useRef(false);

    final routeScrollController = ModalScrollController.of(context);
    final observer = StyledSheetObserver.maybeOf(context);

    void logScreen(SheetNavigationBreadcrumb breadcrumb) {
      if (StyledSheetObserver.getScreenName(breadcrumb.path) case final screenName?) {
        observer?.onScreenShown(screenName);
      }
    }

    void runTransition(SheetTransition transition, {required double target}) {
      transitionState.value = transition;
      animationController.animateTo(target, curve: Curves.easeOutCubic).whenCompleteOrCancel(() {
        if (context.mounted && transitionState.value == transition) transitionState.value = null;
      });
    }

    useOnListenableChange(navigation, () {
      final previousBreadcrumbs = previousBreadcrumbsRef.value;
      previousBreadcrumbsRef.value = navigation.value;
      final from = previousBreadcrumbs.last;
      final to = navigation.currentBreadcrumb;
      if (from == to) return;

      logScreen(to);

      // An edge swipe pops to the breadcrumb it was already revealing, so its transition only needs to finish.
      if (transitionState.value case final swipeTransition? when swipeTransition.to == to) {
        runTransition(swipeTransition, target: 1);
        return;
      }

      animationController.value = 0;
      runTransition(
        SheetTransition(fromBreadcrumbs: previousBreadcrumbs, to: to, isForward: navigation.value.contains(from)),
        target: 1,
      );
    });

    void startSwipe(DragStartDetails details) {
      if (transitionState.value != null || navigation.value.length < 2) return;

      isSwipingRef.value = true;
      animationController.value = 0;
      transitionState.value = SheetTransition(
        fromBreadcrumbs: navigation.value,
        to: navigation.value[navigation.value.length - 2],
        isForward: false,
      );
    }

    void endSwipe({required double velocity}) {
      if (!isSwipingRef.value) return;
      isSwipingRef.value = false;

      final swipeTransition = transitionState.value!;
      final fractionalVelocity = velocity / context.size!.width;
      final shouldPop = fractionalVelocity.abs() >= 1 ? fractionalVelocity > 0 : animationController.value > 0.5;
      if (shouldPop) {
        navigation.popTo(swipeTransition.to);
      } else {
        runTransition(swipeTransition, target: 0);
      }
    }

    final entryBreadcrumbs = [
      ...breadcrumbs.mapIndexed((index, _) => breadcrumbs.take(index + 1).toList()),
      if (transition != null && !breadcrumbs.contains(transition.from)) transition.fromBreadcrumbs,
    ];
    final visibleBreadcrumbs = {breadcrumbs.last, ?transition?.from, ?transition?.to};

    final children = entryBreadcrumbs
        .map(
          (trail) => SheetNavigatorEntry(
            key: ObjectKey(trail.last),
            breadcrumbContext: SheetNavigationBreadcrumbContext(navigation: navigation, breadcrumbs: trail),
            // Drag-to-dismiss only follows the route's scroll controller, so the top breadcrumb takes it over.
            routeScrollController: trail.last == breadcrumbs.last ? routeScrollController : null,
            isVisible: visibleBreadcrumbs.contains(trail.last),
          ),
        )
        .toList();

    int getIndex(SheetNavigationBreadcrumb breadcrumb) =>
        entryBreadcrumbs.indexWhere((trail) => trail.last == breadcrumb);

    return PopScope(
      canPop: breadcrumbs.length == 1,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && navigation.value.length > 1) navigation.popTo(navigation.value[navigation.value.length - 2]);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surfacePrimary,
          borderRadius: .vertical(top: .circular(16)),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, _) => SheetNavigatorLayout(
                toIndex: getIndex(transition?.to ?? breadcrumbs.last),
                fromIndex: transition == null ? null : getIndex(transition.from),
                progress: animationController.value,
                isForward: transition?.isForward ?? true,
                children: children,
              ),
            ),
            if (defaultTargetPlatform == .iOS && breadcrumbs.length > 1)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 20,
                child: GestureDetector(
                  behavior: .translucent,
                  onHorizontalDragStart: startSwipe,
                  onHorizontalDragUpdate: (details) {
                    if (isSwipingRef.value) animationController.value += details.delta.dx / context.size!.width;
                  },
                  onHorizontalDragEnd: (details) => endSwipe(velocity: details.velocity.pixelsPerSecond.dx),
                  onHorizontalDragCancel: () => endSwipe(velocity: 0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SheetNavigatorEntry extends HookWidget {
  final SheetNavigationBreadcrumbContext breadcrumbContext;
  final ScrollController? routeScrollController;
  final bool isVisible;

  const SheetNavigatorEntry({
    super.key,
    required this.breadcrumbContext,
    required this.routeScrollController,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return TickerMode(
      enabled: isVisible,
      child: ModalScrollController(
        controller: routeScrollController ?? scrollController,
        child: Provider.value(
          value: breadcrumbContext,
          child: HookConsumerBuilder(builder: breadcrumbContext.currentBreadcrumb.sheetBuilder),
        ),
      ),
    );
  }
}

// Breadcrumbs below the top stay laid out so their state and scroll position survive, but only the transitioning
// pair is painted, and the height follows the transition between their natural heights.
class SheetNavigatorLayout extends MultiChildRenderObjectWidget {
  final int toIndex;
  final int? fromIndex;
  final double progress;
  final bool isForward;

  const SheetNavigatorLayout({
    super.key,
    required this.toIndex,
    required this.fromIndex,
    required this.progress,
    required this.isForward,
    required super.children,
  });

  @override
  RenderSheetNavigatorLayout createRenderObject(BuildContext context) => RenderSheetNavigatorLayout()
    ..toIndex = toIndex
    ..fromIndex = fromIndex
    ..progress = progress
    ..isForward = isForward;

  @override
  void updateRenderObject(BuildContext context, RenderSheetNavigatorLayout renderObject) => renderObject
    ..toIndex = toIndex
    ..fromIndex = fromIndex
    ..progress = progress
    ..isForward = isForward
    ..markNeedsLayout();
}

class SheetNavigatorParentData extends ContainerBoxParentData<RenderBox> {}

class RenderSheetNavigatorLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, SheetNavigatorParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, SheetNavigatorParentData> {
  int toIndex = 0;
  int? fromIndex;
  double progress = 1;
  bool isForward = true;

  final clipLayer = LayerHandle<ClipRectLayer>();

  RenderBox get toChild => getChildrenAsList()[toIndex];

  RenderBox? get fromChild => fromIndex == null ? null : getChildrenAsList()[fromIndex!];

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! SheetNavigatorParentData) child.parentData = SheetNavigatorParentData();
  }

  @override
  void performLayout() {
    final childConstraints = BoxConstraints.tightFor(
      width: constraints.maxWidth,
    ).copyWith(maxHeight: constraints.maxHeight);
    getChildrenAsList().forEach((child) => child.layout(childConstraints, parentUsesSize: true));

    final toChild = this.toChild;
    final fromChild = this.fromChild;
    final height = lerpDouble(fromChild?.size.height ?? toChild.size.height, toChild.size.height, progress)!;
    size = constraints.constrain(Size(constraints.maxWidth, height));

    final width = size.width;
    final (toX, fromX) = switch ((fromChild, isForward)) {
      (null, _) => (0.0, 0.0),
      (_, true) => ((1 - progress) * width, -progress * width * 0.3),
      (_, false) => (-(1 - progress) * width * 0.3, progress * width),
    };
    (toChild.parentData! as SheetNavigatorParentData).offset = Offset(toX, 0);
    if (fromChild != null) (fromChild.parentData! as SheetNavigatorParentData).offset = Offset(fromX, 0);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    clipLayer.layer = context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      paintVisibleChildren,
      oldLayer: clipLayer.layer,
    );
  }

  void paintVisibleChildren(PaintingContext context, Offset offset) {
    final toChild = this.toChild;
    final fromChild = this.fromChild;
    if (fromChild == null) {
      paintChild(context, offset, toChild);
      return;
    }

    final (lower, upper) = isForward ? (fromChild, toChild) : (toChild, fromChild);
    paintChild(context, offset, lower);

    final upperOffset = offset + (upper.parentData! as SheetNavigatorParentData).offset;
    final shadowRect = Rect.fromLTWH(upperOffset.dx - 16, upperOffset.dy, 16, upper.size.height);
    context.canvas.drawRect(
      shadowRect,
      Paint()..shader = LinearGradient(colors: [Color(0x00000000), Color(0x1A000000)]).createShader(shadowRect),
    );
    paintChild(context, offset, upper);
  }

  void paintChild(PaintingContext context, Offset offset, RenderBox child) =>
      context.paintChild(child, offset + (child.parentData! as SheetNavigatorParentData).offset);

  // Absorbs taps mid-transition so they can't fall through to the barrier and close the sheet.
  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (fromIndex != null) return false;

    final toChild = this.toChild;
    return result.addWithPaintOffset(
      offset: (toChild.parentData! as SheetNavigatorParentData).offset,
      position: position,
      hitTest: (result, transformed) => toChild.hitTest(result, position: transformed),
    );
  }

  @override
  void dispose() {
    clipLayer.layer = null;
    super.dispose();
  }
}
