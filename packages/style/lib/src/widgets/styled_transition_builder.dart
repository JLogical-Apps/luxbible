import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledTransitionBuilder<T> extends HookWidget {
  final T value;
  final Widget Function(BuildContext, double visibleValue, Widget? child) builder;
  final Widget? child;

  /// The percent of [duration] that should be spent animating the transition vs. holding the `1` value.
  final double percentAnimating;

  const StyledTransitionBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.child,
    this.percentAnimating = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    final tweenValueRef = useRef<double>(1);
    useEffect(() {
      tweenValueRef.value = tweenValueRef.value == 0 ? 1 : 0;
      return null;
    }, [value]);

    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
      tween: Tween<double>(begin: 0, end: tweenValueRef.value),
      builder: (context, value, child) {
        final visibleValue = value < percentAnimating
            ? value / percentAnimating
            : value > (1 - percentAnimating)
            ? (1 - value) / percentAnimating
            : 1.0;
        return builder(context, visibleValue, child);
      },
      child: child,
    );
  }
}
