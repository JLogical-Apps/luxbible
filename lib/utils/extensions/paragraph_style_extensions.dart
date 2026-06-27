import 'package:bible/models/bible/paragraph.dart';
import 'package:flutter/cupertino.dart';

extension SectionTypeStyleExtensions on SectionType {
  TextAlign get textAlign => this == .qa ? .center : .start;
  bool get isLarge => this != .qa && this != .d;
}

extension ParagraphTypeStyleExtensions on ParagraphType {
  TextAlign get textAlign => this == .qr || this == .pr
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
