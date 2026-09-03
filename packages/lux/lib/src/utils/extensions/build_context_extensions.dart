import 'package:flutter/material.dart';
import 'package:lux/src/models/time.dart';
import 'package:lux/src/ui/styled_route.dart';
import 'package:utils_core/utils_core.dart';

extension BuildContextExtensions on BuildContext {
  BuildContext get rootContext => Navigator.of(this, rootNavigator: true).context;
  double get textScaling => MediaQuery.textScalerOf(this).scale(20) / 20;
  TimeFormat get timeFormat => MediaQuery.alwaysUse24HourFormatOf(this) ? .twentyFourHour : .amPm;

  Future<T?> go<T>(StyledRoute<T> Function(BuildContext) pageBuilder) =>
      Navigator.of(this).pushAndRemoveUntil(getStyledRoute(pageBuilder), (_) => false);

  void goToStack(List<StyledRoute<dynamic> Function(BuildContext)> pageBuilders, {Function(BuildContext)? onLoaded}) {
    if (pageBuilders.isEmpty) throw ArgumentError.value(pageBuilders, 'pageBuilders', 'must not be empty');

    final navigator = Navigator.of(this);
    navigator.pushAndRemoveUntil(getStyledRoute(pageBuilders.first), (_) => false);
    pageBuilders.skip(1).forEach((pageBuilder) => navigator.push(getStyledRoute(pageBuilder)));
    if (onLoaded != null) WidgetsBinding.instance.addPostFrameCallback((_) => onLoaded(navigator.context));
  }

  Future<T?> push<T>(StyledRoute<T> Function(BuildContext) pageBuilder) =>
      Navigator.of(this).push(getStyledRoute(pageBuilder));
  Future<T?> pushReplacement<T>(StyledRoute<T> Function(BuildContext) pageBuilder) =>
      Navigator.of(this).pushReplacement(getStyledRoute(pageBuilder));

  Future<T?> pushDialog<T>(StyledRoute<T> Function(BuildContext) pageBuilder) =>
      Navigator.of(this).push(getStyledRoute(pageBuilder, isFullscreenDialog: true));

  void maybePop<T>([T? result]) => Navigator.of(this).maybePop(result);
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  String? getValidationError(Object? error) => switch (error) {
    IsNotBlankValidationError() => 'Cannot be blank',
    null => null,
    _ => error.toString(),
  };

  MaterialPageRoute<T> getStyledRoute<T>(
    StyledRoute<T> Function(BuildContext) pageBuilder, {
    bool isFullscreenDialog = false,
  }) => MaterialPageRoute<T>(
    settings: RouteSettings(name: pageBuilder(this).path),
    builder: pageBuilder,
    fullscreenDialog: isFullscreenDialog,
  );
}
