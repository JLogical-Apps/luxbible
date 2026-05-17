import 'package:flutter/material.dart';

class KeyedScrollNotification extends Notification {
  final Object key;
  final ScrollMetrics metrics;
  final ViewportNotificationMixin originalNotification;

  const KeyedScrollNotification({required this.key, required this.metrics, required this.originalNotification});
}
