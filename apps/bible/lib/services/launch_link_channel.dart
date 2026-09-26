import 'package:flutter/services.dart';

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

  Future<String?> getLaunchValue() => channel.invokeMethod<String>(launchMethod);
}
