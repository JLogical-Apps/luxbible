import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

int useReloadCount() => use(ReloadCountHook());

class ReloadCountHook extends Hook<int> {
  @override
  ReloadCountHookState createState() => ReloadCountHookState();
}

class ReloadCountHookState extends HookState<int, ReloadCountHook> {
  var count = 0;

  @override
  void reassemble() {
    super.reassemble();
    count++;
  }

  @override
  int build(BuildContext context) => count;
}
