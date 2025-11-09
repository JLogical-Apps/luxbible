import 'package:bible/utils/extensions/controller_extensions.dart';
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
  ScrollController scrollController,
  Function(ScrollDirection) onScrollDirectionChanged,
) {
  final previousScrollDirectionRef = useRef(ScrollDirection.idle);
  useOnListenableChange(scrollController, () {
    final direction = scrollController.positionsOrNull?.firstOrNull?.userScrollDirection;
    if (direction == null ||
        direction == ScrollDirection.idle ||
        direction == previousScrollDirectionRef.value) {
      return;
    }

    previousScrollDirectionRef.value = direction;
    onScrollDirectionChanged(direction);
  });
}

void usePostFrameEffect(Function() effect, [List<Object?>? keys]) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) => effect());
    return null;
  }, keys ?? []);
}

bool useIsFirstFrame() {
  final isFirstFrameState = useState(true);
  usePostFrameEffect(() => isFirstFrameState.value = false);
  return isFirstFrameState.value;
}
