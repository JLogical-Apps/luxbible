import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomMaterialTextSelectionControls extends MaterialTextSelectionControls {
  static const double verticalOffset = 8;

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) =>
      super.getHandleAnchor(type, textLineHeight) + Offset(0, verticalOffset);

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) => SizedBox.shrink();
}

class CustomCupertinoTextSelectionControls extends CupertinoTextSelectionControls {
  static const double verticalOffset = 8;

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) =>
      super.getHandleAnchor(type, textLineHeight) + Offset(0, verticalOffset);

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) => SizedBox.shrink();
}
