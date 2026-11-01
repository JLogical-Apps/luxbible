import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:style/src/widgets/sheet/styled_sheet_observer.dart';

class StyledSheetRoute<T> extends ModalSheetRoute<T> {
  final String? Function() getPath;

  StyledSheetRoute({required super.builder, required this.getPath})
    : super(
        expanded: false,
        containerBuilder: (context, animation, child) => Material(color: Colors.transparent, child: child),
      );

  // Breadcrumbs change inside this route, so its name follows the top one when a sheet above it closes.
  @override
  RouteSettings get settings => RouteSettings(name: StyledSheetObserver.getScreenName(getPath()));

  // Back gestures step back a breadcrumb through PopScope, but tapping outside always closes the whole sheet.
  @override
  Widget buildModalBarrier() => AnimatedModalBarrier(
    // While offstage for hero measurement, the route's animation reads as complete for the first frame.
    color: offstage
        ? AlwaysStoppedAnimation(Colors.transparent)
        : animation!.drive(
            ColorTween(
              begin: barrierColor.withValues(alpha: 0),
              end: barrierColor,
            ).chain(CurveTween(curve: barrierCurve)),
          ),
    dismissible: barrierDismissible,
    onDismiss: () => navigator?.pop(),
  );
}
