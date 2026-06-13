import 'package:bible/models/bible/paragraph.dart';
import 'package:flutter/cupertino.dart';

extension ParagraphTypeStyleExtensions on ParagraphType {
  FontStyle get fontStyle => this == .d ? .italic : .normal;
  TextAlign get textAlign => this == .qr ? .end : .start;

  double get indent => switch (this) {
    .q1 || .li1 => 0,
    .pi => 40,
    _ => 20,
  };

  double get hangingIndent => this == .q1 || this == .q2 ? 30 : 0;
  double get blockIndent => hangingIndent == 0 ? 0 : indent;

  EdgeInsets get padding => switch (this) {
    .li1 => .symmetric(horizontal: 16),
    .li2 => .symmetric(horizontal: 24),
    _ => .zero,
  };
}
