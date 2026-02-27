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
  Function(ScrollDirection) onScrollDirectionChanged, [
  List<Object?> keys = const [],
]) {
  final previousScrollDirectionRef = useRef(ScrollDirection.idle);
  final directionChangeStartRef = useRef<double?>(null);
  useEffect(() {
    previousScrollDirectionRef.value = ScrollDirection.idle;
    return null;
  }, keys);
  useOnListenableChange(scrollController, () {
    final position = scrollController.positionsOrNull?.firstOrNull;
    final direction = position?.userScrollDirection;
    if (position == null || direction == null || direction == ScrollDirection.idle) {
      return;
    }

    if (direction == previousScrollDirectionRef.value) {
      directionChangeStartRef.value = null;
      return;
    }

    final directionChangeStart = directionChangeStartRef.value;
    if (directionChangeStart == null) {
      directionChangeStartRef.value = position.pixels;
      return;
    }

    if ((direction == ScrollDirection.reverse && position.pixels > directionChangeStart + 10) ||
        (direction == ScrollDirection.forward && position.pixels < directionChangeStart - 10)) {
      previousScrollDirectionRef.value = direction;
      onScrollDirectionChanged(direction);
      directionChangeStartRef.value = null;
    }
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

void useOnDispose(Function() disposer, [List<Object?>? keys]) => useEffect(() => disposer, keys ?? []);

T useDisposable<T>(T object, Function(T) onDispose) {
  useOnDispose(() => onDispose(object), [object]);
  return object;
}
