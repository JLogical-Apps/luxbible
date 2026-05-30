import 'package:bible/models/bible/paragraph.dart';
import 'package:flutter/cupertino.dart';

extension ParagraphTypeStyleExtensions on ParagraphType {
  FontStyle get fontStyle => this == ParagraphType.d ? FontStyle.italic : FontStyle.normal;
  TextAlign get textAlign => this == ParagraphType.qr ? TextAlign.end : TextAlign.start;

  double get indent => switch (this) {
    ParagraphType.q1 || ParagraphType.li1 => 0,
    _ => 20,
  };

  EdgeInsets get padding => switch (this) {
    ParagraphType.li1 => EdgeInsets.symmetric(horizontal: 16),
    ParagraphType.li2 => EdgeInsets.symmetric(horizontal: 24),
    _ => EdgeInsets.zero,
  };
}
