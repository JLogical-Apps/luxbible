import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useOnFocusNodeFocused(FocusNode focusNode, Function() onFocused) {
  useOnListenableChange(focusNode, () {
    if (focusNode.hasPrimaryFocus) {
      onFocused();
    }
  });
}

ScrollController useUnfocusOnScrollDown(ScrollController scrollController) {
  useOnListenableChange(scrollController, () {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  });
  return scrollController;
}

void useOnStickyScrollDirectionChanged(
  ScrollPosition? position,
  Function(ScrollDirection) onScrollDirectionChanged,
) {
  useEffect(() {
    if (position == null || position.userScrollDirection == ScrollDirection.idle) {
      return null;
    }

    onScrollDirectionChanged(position.userScrollDirection);
    return null;
  }, [position?.userScrollDirection]);
}
