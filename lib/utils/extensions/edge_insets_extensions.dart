import 'package:flutter/material.dart';

extension EdgeInsetsExtensions on EdgeInsets {
  EdgeInsets copyWith({double? top, double? left, double? right, double? bottom}) => EdgeInsets.only(
    left: left ?? this.left,
    bottom: bottom ?? this.bottom,
    right: right ?? this.right,
    top: top ?? this.top,
  );

  EdgeInsets get onlyHorizontal => copyWith(top: 0, bottom: 0);
}
