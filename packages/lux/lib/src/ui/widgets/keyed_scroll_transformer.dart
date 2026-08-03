import 'package:lux/src/ui/widgets/keyed_scroll_notification.dart';
import 'package:flutter/material.dart';

class KeyedScrollTransformer extends StatelessWidget {
  final Object? scrollKey;
  final Widget child;

  const KeyedScrollTransformer({super.key, required this.scrollKey, required this.child});

  @override
  Widget build(BuildContext context) {
    final scrollKey = this.scrollKey;
    if (scrollKey == null) {
      return child;
    }

    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (e) {
        KeyedScrollNotification(key: scrollKey, originalNotification: e, metrics: e.metrics).dispatch(context);
        return true;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (e) {
          KeyedScrollNotification(key: scrollKey, originalNotification: e, metrics: e.metrics).dispatch(context);
          return true;
        },
        child: child,
      ),
    );
  }
}
