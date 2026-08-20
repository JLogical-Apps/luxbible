import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/src/utils/extensions/controller_extensions.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:utils_core/utils_core.dart';

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

ObjectRef<T> usePassthrough<T>(T value) => useRef(value)..value = value;

StreamSubscription<T>? useOnStreamData<T>(Stream<T>? stream, Function(T) onData) {
  final onDataRef = usePassthrough(onData);
  return useOnStreamChange(stream, onData: (data) => onDataRef.value(data));
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

ListController useListController([List<Object> keys = const []]) =>
    useDisposable(useMemoized(() => ListController(), keys), (controller) => controller.dispose());

T useChangeNotifier<T extends ChangeNotifier>(T Function() notifierBuilder, {bool listen = true}) {
  final changeNotifier = useDisposable<T>(useMemoized(notifierBuilder), (notifier) => notifier.dispose());
  return listen ? useListenable(changeNotifier) : changeNotifier;
}

Registry<K, V> useRegistry<K, V>({bool listen = true}) =>
    useChangeNotifier(() => Registry<K, V>(items: {}), listen: listen);

void useRegistryItem<K, V>(Registry<K, V> registry, K key, V item) => useEffect(() {
  WidgetsBinding.instance.addPostFrameCallback((_) => registry.register(key, item));
  return () => WidgetsBinding.instance.addPostFrameCallback((_) => registry.disposeOf(key, item));
}, [registry, key, item]);

class Registry<K, V> extends ChangeNotifier {
  final Map<K, V> items;

  bool _isDisposed = false;

  Registry({required this.items});

  void register(K key, V item) {
    items[key] = item;
    if (!_isDisposed) notifyListeners();
  }

  void disposeOf(K key, V item) {
    if (!identical(items[key], item)) return;
    items.remove(key);
    if (!_isDisposed) notifyListeners();
  }

  V? operator [](K key) => items[key];

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class MapTween<K, T extends Object> extends Tween<Map<K, T>> {
  final T initialValue;

  MapTween({required Map<K, T> begin, required Map<K, T> end, required T initialValue})
    : initialValue = initialValue,
      super(begin: end.mapValues((key, value) => begin[key] ?? initialValue), end: Map.of(end));

  @override
  Map<K, T> lerp(double t) =>
      end!.mapValues((key, endValue) => Tween(begin: begin![key] ?? initialValue, end: endValue).transform(t));
}

Map<K, T> useAnimatedValues<K, T extends Object>(Map<K, T> targetValues, {required T initialValue}) {
  final controller = useAnimationController(duration: Duration(milliseconds: 300));
  final progress = useAnimation(controller);

  final curve = Curves.easeInOutCubic;

  final activeTweenRef = useRef<MapTween<K, T>?>(null);
  final previousTargetValues = usePrevious(targetValues);

  var shouldRestart = false;

  final hasTargetsChanged = !mapEquals(previousTargetValues, targetValues);
  if (hasTargetsChanged) {
    final activeTween = activeTweenRef.value;
    shouldRestart = targetValues.entries.any((entry) {
      final previousTarget = activeTween?.end?[entry.key];
      return previousTarget == null ? initialValue != entry.value : previousTarget != entry.value;
    });

    final beginValues = switch ((activeTween, shouldRestart)) {
      (final activeTween?, true) => activeTween.transform(curve.transform(progress)),
      (final activeTween?, false) => activeTween.begin!,
      _ => <K, T>{},
    };
    activeTweenRef.value = MapTween(begin: beginValues, end: targetValues, initialValue: initialValue);
  }

  final activeTween = activeTweenRef.value;
  useEffect(() {
    if (shouldRestart) controller.forward(from: 0);
    return null;
  }, [controller, activeTween]);

  final curvedProgress = curve.transform(shouldRestart ? 0 : progress);
  return activeTween?.transform(curvedProgress) ?? {};
}

T useIf<T>(T value, bool Function(T) predicate, [List<Object?> keys = const []]) {
  final ref = useRef(value);
  useEffect(() {
    if (predicate(value)) ref.value = value;
    return null;
  }, [value, ...keys]);

  return ref.value;
}

T useWhenVisible<T>(T value) {
  final context = useContext();
  final isVisible = ModalRoute.of(context)?.isCurrent ?? true;
  return useIf(value, (_) => isVisible, [isVisible]);
}

void useWhenValueChanged<T>(T value, Function(T prev, T curr) callback) =>
    useValueChanged<T, void>(value, (old, _) => callback(old, value));

T useDependentState<T>(T Function() stateBuilder, List<Object?> keys) {
  final state = useState(stateBuilder());
  usePostFrameEffect(() => state.value = stateBuilder(), keys);
  return state.value;
}
