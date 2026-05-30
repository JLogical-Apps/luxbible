import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledReorderableList extends HookWidget {
  static Size? draggedChildSize;

  final List<Widget> children;
  final Function(int oldIndex, int newIndex) onReorder;

  const StyledReorderableList({super.key, required this.children, required this.onReorder});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: children
          .mapIndexed(
            (i, child) => StyledListItemContext(key: child.key, showDivider: i + 1 < children.length, child: child),
          )
          .toList(),
      onReorderItem: onReorder,
      proxyDecorator: (widget, _, _) => Container(
        decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
        child: widget,
      ),
    );

    final listKey = useMemoized(() => GlobalKey());

    final refreshState = useState(0);

    final reorderingIndexState = useState<int?>(null);
    final reorderingIndex = reorderingIndexState.value;

    final dragDataState = useState<int?>(null);
    final newPositionIndex = dragDataState.value;

    final dividerChildrenLength = children.length - (reorderingIndex == children.length - 1 ? 1 : 0);

    Widget dragTarget(int? index) => DragTarget<int>(
      onAcceptWithDetails: (details) {
        if (index == null) {
          return;
        }

        dragDataState.value = null;

        final fromIndex = details.data;

        var toIndex = index;
        if (toIndex > fromIndex) {
          toIndex--;
        }

        onReorder(fromIndex, toIndex);
        refreshState.value++;
      },
      onWillAcceptWithDetails: (details) {
        dragDataState.value = index;
        return index != null;
      },
      builder: (context, accepted, rejected) => SizedBox.shrink(),
    );

    useEffect(() {
      void listener(PointerEvent event) {
        final renderBox = listKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox == null) {
          return;
        }

        final position = renderBox.localToGlobal(.zero);
        final size = renderBox.size;
        final rect = position & size;

        final inside = rect.contains(event.position);

        if (!inside && dragDataState.value != null) {
          dragDataState.value = null;
        }
      }

      GestureBinding.instance.pointerRouter.addGlobalRoute(listener);
      return () => GestureBinding.instance.pointerRouter.removeGlobalRoute(listener);
    }, []);

    return KeyedSubtree(
      key: listKey,
      child: Column(
        key: ValueKey(refreshState.value),
        children: [
          ...children.mapIndexed((i, child) {
            final isLast = i + 1 >= dividerChildrenLength && newPositionIndex != i + 1;
            return StyledListItemContext(
              showDivider: !isLast,
              child: Column(
                children: [
                  AnimatedSize(
                    alignment: .bottomCenter,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: newPositionIndex == i
                        ? SizedBox(width: double.infinity, height: draggedChildSize?.height ?? 0, child: dragTarget(i))
                        : SizedBox(key: ValueKey('empty'), width: double.infinity),
                  ),
                  // SizeMeasureBuilder(
                  //   builder: (context, size) {
                  //     final denominator = canOverlay ? 4 : 2;
                  //     final childWithDragTargets = Stack(
                  //       children: [
                  //         child,
                  //         if (canOverlay) Positioned.fill(child: dragTarget(null)),
                  //         Positioned(
                  //           top: 0,
                  //           left: 0,
                  //           right: direction == Axis.vertical ? 0 : null,
                  //           bottom: direction == Axis.vertical ? null : 0,
                  //           width: direction == Axis.vertical
                  //               ? null
                  //               : min(_maxDragTargetSize, (size?.width ?? 0) / denominator),
                  //           height: direction == Axis.vertical
                  //               ? min(_maxDragTargetSize, (size?.height ?? 0) / denominator)
                  //               : null,
                  //           child: dragTarget(i),
                  //         ),
                  //         Positioned(
                  //           top: direction == Axis.vertical ? null : 0,
                  //           bottom: 0,
                  //           left: direction == Axis.vertical ? 0 : null,
                  //           right: 0,
                  //           width: direction == Axis.vertical
                  //               ? null
                  //               : min(_maxDragTargetSize, (size?.width ?? 0) / denominator),
                  //           height: direction == Axis.vertical
                  //               ? min(_maxDragTargetSize, (size?.height ?? 0) / denominator)
                  //               : null,
                  //           child: dragTarget(i + 1),
                  //         ),
                  //       ],
                  //     );
                  //
                  //     return StyledDraggable<StyledReorderableListDragData<T>>(
                  //       key: ValueKey(i),
                  //       direction: direction,
                  //       enabled: onReorder != null,
                  //       child: KeyedSubtree(
                  //         key: childrenKeys[i],
                  //         child: direction == Axis.horizontal
                  //             ? IntrinsicWidth(child: childWithDragTargets)
                  //             : childWithDragTargets,
                  //       ),
                  //       feedbackBuilder: (data) => FirstFrameBuilder(
                  //         builder: (context, isFirstFrame) => Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: feedbackBorderRadius,
                  //             color: useFeedbackBackgroundColor ? context.colors.surface : Colors.transparent,
                  //             boxShadow: [StyledShadow.down(context)],
                  //           ),
                  //           child: childrenBuilder(context, !isFirstFrame)[data.index],
                  //         ),
                  //       ),
                  //       data: (listKey: listKey, data: toDragData?.call(i), index: i),
                  //       onDragUpdated: (data, isDragging) {
                  //         if (isDragging) {
                  //           draggedChildSize = size;
                  //           reorderingIndexState.value = data.index;
                  //         } else {
                  //           reorderingIndexState.value = null;
                  //           dragDataState.value = null;
                  //         }
                  //         final dragData = data.data;
                  //         if (dragData != null) {
                  //           onDragUpdated?.call(dragData, isDragging);
                  //         }
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          }),
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: newPositionIndex == children.length
                ? SizedBox(
                    width: double.infinity,
                    height: draggedChildSize?.height ?? 0,
                    child: dragTarget(children.length),
                  )
                : SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
