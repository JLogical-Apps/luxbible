import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Seconds since the widget mounted, for slow ambient motion. It stays at zero when the system asks to reduce motion,
// and the ticker pauses on its own while the route is covered or the app is in the background.
// The calling widget rebuilds every frame, so only call this from a small leaf widget.
double useAmbientTime() {
  final isAnimated = !MediaQuery.disableAnimationsOf(useContext());
  final time = useState(0.0);
  final tickerProvider = useSingleTickerProvider(keys: [isAnimated]);

  useEffect(() {
    if (!isAnimated) {
      time.value = 0;
      return null;
    }
    final ticker = tickerProvider.createTicker(
      (elapsed) => time.value = elapsed.inMicroseconds / Duration.microsecondsPerSecond,
    )..start();
    return ticker.dispose;
  }, [isAnimated]);

  return time.value;
}
