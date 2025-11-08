import 'package:flutter_hooks/flutter_hooks.dart';

Function() useRefresh() {
  final state = useState(0);
  return () => state.value++;
}
