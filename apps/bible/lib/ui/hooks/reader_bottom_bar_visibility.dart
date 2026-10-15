import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';

class ReaderBottomBarVisibility {
  final bool isVisible;
  final Function() show;

  ReaderBottomBarVisibility({required this.isVisible, required this.show});
}

ReaderBottomBarVisibility useReaderBottomBarVisibility({
  required ScrollController? scrollController,
  required bool isPinned,
  required bool hasSelection,
  List<Object?> keys = const [],
}) {
  final isScrollingUpState = useState(true);
  final isAtBottom = useListenableSelector(scrollController, () {
    final scrollPosition = scrollController?.positionOrNull;
    return scrollPosition == null || !scrollPosition.hasContentDimensions
        ? false
        : scrollPosition.pixels >= scrollPosition.maxScrollExtent;
  });

  useOnStickyScrollDirectionChanged(
    scrollController,
    (direction) => isScrollingUpState.value = direction == .forward,
    keys,
  );

  return ReaderBottomBarVisibility(
    isVisible: (isScrollingUpState.value || isPinned || isAtBottom) && !hasSelection,
    show: () => isScrollingUpState.value = true,
  );
}
