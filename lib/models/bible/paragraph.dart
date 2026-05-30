import 'package:bible/models/bible/verse.dart';
import 'package:flutter/cupertino.dart';

sealed class Paragraph {
  const Paragraph();
}

class SectionParagraph extends Paragraph {
  final String text;
  final SectionType type;

  const SectionParagraph({required this.text, required this.type});
}

class VersesParagraph extends Paragraph {
  final List<Verse> verses;
  final int firstVerseOffset;
  final ParagraphType type;

  const VersesParagraph({required this.verses, this.firstVerseOffset = 0, required this.type});
}

class BreakParagraph extends Paragraph {
  static const BreakParagraph _instance = BreakParagraph._();

  const BreakParagraph._();

  factory BreakParagraph() => _instance;
}

enum SectionType { s1, s2 }

enum ParagraphType {
  p,
  d,
  q1,
  q2,
  qr,
  li1,
  li2;

  bool get isPoetic => this == q1 || this == q2 || this == qr;

  FontStyle get fontStyle => this == d ? .italic : .normal;
  TextAlign get textAlign => this == qr ? .end : .start;

  double get indent => switch (this) {
    q1 || li1 => 0,
    _ => 20,
  };

  EdgeInsets get padding => switch (this) {
    li1 => .symmetric(horizontal: 16),
    li2 => .symmetric(horizontal: 24),
    _ => .zero,
  };
}
