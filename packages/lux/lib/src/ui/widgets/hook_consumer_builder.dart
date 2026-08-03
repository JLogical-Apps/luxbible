import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HookConsumerBuilder extends StatelessWidget {
  final Widget Function(BuildContext, WidgetRef) builder;

  const HookConsumerBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) =>
      Consumer(builder: (context, ref, child) => HookBuilder(builder: (context) => builder(context, ref)));
}
