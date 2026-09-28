import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LaunchLinkChannel {
  final MethodChannel channel;
  final String launchMethod;
  final String openMethod;

  LaunchLinkChannel(String name, {required this.launchMethod, required this.openMethod})
    : channel = MethodChannel(name);

  void listen(Function(String) onOpen) {
    channel.setMethodCallHandler((call) async {
      if (call.arguments case final String value when call.method == openMethod) onOpen(value);
    });
  }

  Future<String?> getLaunchValue() => invokeMethod<String>(launchMethod);

  Future<T?> invokeMethod<T>(String method, [Object? arguments]) async {
    await waitUntilAttached();
    return channel.invokeMethod<T>(method, arguments);
  }

  // Android's audio service can run Dart without an activity, and MainActivity only registers the
  // native side of these channels when it attaches, which always happens before it first resumes.
  static Future<void> waitUntilAttached() async {
    if (WidgetsBinding.instance.lifecycleState == .resumed) return;

    final completer = Completer<void>();
    final listener = AppLifecycleListener(onResume: completer.complete);
    await completer.future;
    listener.dispose();
  }
}
