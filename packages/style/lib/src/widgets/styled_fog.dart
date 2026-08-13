import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledFog extends HookWidget {
  final Widget child;

  const StyledFog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final metricsState = useState<ScrollMetrics?>(null);
    final metrics = metricsState.value;

    final (showLeftShadow, showRightShadow) = metrics == null
        ? (false, false)
        : (metrics.pixels > 3, metrics.pixels + 3 < metrics.maxScrollExtent);

    bool updateMetrics(ScrollMetrics value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) metricsState.value = value;
      });
      return false;
    }

    Widget linearFade({required Widget child, required bool enabled, required Alignment alignment}) =>
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
          tween: ColorTween(
            begin: Colors.white,
            end: Colors.white.withValues(alpha: enabled ? 0 : 1),
          ),
          child: child,
          builder: (context, color, child) => ShaderMask(
            blendMode: .dstIn,
            shaderCallback: (bounds) {
              final fadeFraction = bounds.width == 0 ? 0.5 : (20 / bounds.width).clamp(0.0, 0.5);
              return LinearGradient(
                colors: alignment == .centerLeft
                    ? [color!, Colors.white, Colors.white]
                    : [Colors.white, Colors.white, color!],
                stops: [0, alignment == .centerLeft ? fadeFraction : (1 - fadeFraction), 1],
              ).createShader(bounds);
            },
            child: child,
          ),
        );

    return NotificationListener<ScrollNotification>(
      onNotification: (event) => updateMetrics(event.metrics),
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: (event) => updateMetrics(event.metrics),
        child: linearFade(
          alignment: .centerLeft,
          enabled: showLeftShadow,
          child: linearFade(child: child, enabled: showRightShadow, alignment: .centerRight),
        ),
      ),
    );
  }
}
