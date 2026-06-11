import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The application-wide [ProviderContainer], assigned once in `main`.
///
/// Use this to read providers from non-widget code (models, actions, sheets)
/// without needing a [BuildContext], and without the lifecycle fragility of
/// looking the container up through the widget tree.
///
/// Widgets should keep using their [WidgetRef] in `build` for `watch`/`listen`.
late final ProviderContainer ref;
