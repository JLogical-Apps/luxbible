import 'dart:async';

import 'package:lux/src/utils/extensions/controller_extensions.dart';
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

void useOnLocalesChanged(Function(List<Locale>?) onLocalesChanged) => useEffect(() {
  final observer = _LocalesObserver(onLocalesChanged);
  WidgetsBinding.instance.addObserver(observer);
  return () => WidgetsBinding.instance.removeObserver(observer);
}, []);

class _LocalesObserver with WidgetsBindingObserver {
  final Function(List<Locale>?) onLocalesChanged;

  _LocalesObserver(this.onLocalesChanged);

  @override
  void didChangeLocales(List<Locale>? locales) => onLocalesChanged(locales);
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
  ScrollController? scrollController,
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
    final position = scrollController?.positionsOrNull?.firstOrNull;
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

void useOnPostFrameListenableChange(Listenable? listenable, Function() listener, [List<Object?> keys = const []]) {
  usePostFrameEffect(() => listener(), [listenable, ...keys]);
  useOnListenableChange(listenable, () => WidgetsBinding.instance.addPostFrameCallback((_) => listener()));
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

Function() useRefresh() {
  final state = useState(0);
  return () => state.value++;
}

void usePeriodic(Duration duration, Function() callback) {
  final callbackRef = useRef(callback);
  callbackRef.value = callback;
  useEffect(() {
    final timer = Timer.periodic(duration, (_) => callbackRef.value());
    return timer.cancel;
  }, []);
}

ValueNotifier<T> usePassthrough<T>(T value) {
  final state = useMemoized(() => ValueNotifier(value));
  usePostFrameEffect(() => state.value = value, [value]);
  return state;
}

void useOneTimeEffect(Function() effect) => useEffect(() => effect(), []);

bool useOnContentLoaded({ScrollController? controller, Function(double maxScrollExtent)? onContentLoaded}) {
  final isLoadedState = useState(false);
  usePostFrameEffect(() {
    final position = controller?.positionOrNull;
    if (!isLoadedState.value && position != null) {
      onContentLoaded?.call(position.maxScrollExtent);
      isLoadedState.value = true;
    }
  }, [controller != null, controller?.positionOrNull != null]);
  return isLoadedState.value;
}
