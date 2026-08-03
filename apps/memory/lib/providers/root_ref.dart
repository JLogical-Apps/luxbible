import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The application-wide [ProviderContainer], assigned once in `main`.
///
/// Use this to read providers from non-widget code without needing a
/// [BuildContext] or looking the container up through the widget tree.
///
/// Widgets should keep using their [WidgetRef] in `build` for `watch` and
/// `listen`.
late final ProviderContainer ref;
