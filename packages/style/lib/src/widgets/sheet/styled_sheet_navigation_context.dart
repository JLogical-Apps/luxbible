import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:style/src/widgets/sheet/styled_sheet.dart';

class SheetNavigationBreadcrumb {
  final String text;
  final String? path;
  final StyledSheet Function(BuildContext, WidgetRef) sheetBuilder;

  final Completer<Object?> _resultCompleter = Completer();

  SheetNavigationBreadcrumb({required this.text, this.path, required this.sheetBuilder});

  Future<Object?> get result => _resultCompleter.future;

  void _complete(Object? result) {
    if (!_resultCompleter.isCompleted) _resultCompleter.complete(result);
  }
}

// Breadcrumbs share one sheet route, so a breadcrumb's result arrives when it's popped or the whole sheet closes.
class SheetNavigation extends ValueNotifier<List<SheetNavigationBreadcrumb>> {
  bool _isClosed = false;

  SheetNavigation(SheetNavigationBreadcrumb root) : super([root]);

  SheetNavigationBreadcrumb get currentBreadcrumb => value.last;

  void push(SheetNavigationBreadcrumb breadcrumb, {required SheetNavigationBreadcrumb above}) {
    // A sheet can push after an await, by which time it may be covered, popped, or closed, so the push is dropped.
    if (_isClosed || above != currentBreadcrumb) {
      breadcrumb._complete(null);
      return;
    }

    value = [...value, breadcrumb];
  }

  void popTo(SheetNavigationBreadcrumb breadcrumb) {
    final index = value.indexOf(breadcrumb);
    for (final removed in value.skip(index + 1)) {
      removed._complete(null);
    }
    value = value.take(index + 1).toList();
  }

  void close(Object? result) {
    _isClosed = true;
    currentBreadcrumb._complete(result);
    for (final breadcrumb in value) {
      breadcrumb._complete(null);
    }
  }
}

class SheetNavigationBreadcrumbContext {
  final SheetNavigation navigation;
  final List<SheetNavigationBreadcrumb> breadcrumbs;

  SheetNavigationBreadcrumbContext({required this.navigation, required this.breadcrumbs});

  SheetNavigationBreadcrumb get currentBreadcrumb => breadcrumbs.last;
}
