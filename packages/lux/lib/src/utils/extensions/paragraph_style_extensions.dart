import 'package:flutter/cupertino.dart';
import 'package:lux/lux.dart';

extension SectionTypeStyleExtensions on SectionType {
  bool get isLarge => this != .qa && this != .d && this != .sp;
  bool get isInline => this == .sp;
}

extension ParagraphTypeStyleExtensions on ParagraphType {
  TextAlign get textAlign => this == .qr || this == .qs || this == .pr
      ? .end
      : this == .qc || this == .pc
      ? .center
      : .start;

  EdgeInsets get padding => switch (this) {
    .li1 => .symmetric(horizontal: 16),
    .li2 => .symmetric(horizontal: 24),
    _ => .zero,
  };
}
