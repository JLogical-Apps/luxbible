import 'package:flutter/material.dart';

class ScrollAbsorber extends StatelessWidget {
  final bool Function(ViewportNotificationMixin, ScrollMetrics) allowPropagate;
  final Widget child;

  ScrollAbsorber({
    super.key,
    bool Function(ViewportNotificationMixin, ScrollMetrics)? allowPropagate,
    required this.child,
  }) : allowPropagate = allowPropagate ?? ((e, metrics) => false);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (e) => !allowPropagate(e, e.metrics),
      child: NotificationListener<ScrollNotification>(
        onNotification: (e) => !allowPropagate(e, e.metrics),
        child: child,
      ),
    );
  }
}
