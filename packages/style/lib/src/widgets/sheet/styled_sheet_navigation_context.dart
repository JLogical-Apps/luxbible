import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:provider/provider.dart' show ReadContext;
import 'package:style/src/widgets/sheet/styled_sheet.dart';

class SheetNavigationBreadcrumbContext {
  final List<SheetNavigationBreadcrumb> breadcrumbs;

  const SheetNavigationBreadcrumbContext({required this.breadcrumbs});

  SheetNavigationBreadcrumb get currentBreadcrumb => breadcrumbs.last;

  SheetNavigationBreadcrumbContext withBreadcrumb(SheetNavigationBreadcrumb breadcrumb) =>
      SheetNavigationBreadcrumbContext(breadcrumbs: [...breadcrumbs, breadcrumb]);

  SheetNavigationBreadcrumbContext withBreadcrumbsUpTo(int breadcrumbIndex) =>
      SheetNavigationBreadcrumbContext(breadcrumbs: breadcrumbs.take(breadcrumbIndex + 1).toList());
}

class SheetNavigationBreadcrumb {
  final String text;
  final String? path;
  final StyledSheet Function(BuildContext, WidgetRef) sheetBuilder;

  double scrollOffset = 0;
  final List<ValueNotifier<Object?>> states = [];

  BuildContext? stateContext;
  int nextStateIndex = 0;

  SheetNavigationBreadcrumb({required this.text, this.path, required this.sheetBuilder});

  // Each mount of the sheet claims its states in call order, the same way hooks resolve.
  ValueNotifier<T> getState<T>(BuildContext context, T Function() initialValue) {
    if (stateContext != context) {
      assert(stateContext?.mounted != true, 'useSheetState can only be called from the sheet builder itself.');
      stateContext = context;
      nextStateIndex = 0;
    }

    final index = nextStateIndex++;
    if (index == states.length) states.add(ValueNotifier<T>(initialValue()));
    return states[index] as ValueNotifier<T>;
  }
}

// Going back through breadcrumbs rebuilds a sheet from scratch, so hook state would otherwise reset.
ValueNotifier<T> useSheetState<T>(T Function() initialValue) {
  final context = useContext();
  final breadcrumb = context.read<SheetNavigationBreadcrumbContext?>()?.currentBreadcrumb;
  return useListenable(
    useDisposable(
      useMemoized(() => breadcrumb?.getState(context, initialValue) ?? ValueNotifier(initialValue())),
      (state) => breadcrumb == null ? state.dispose() : null,
    ),
  );
}
