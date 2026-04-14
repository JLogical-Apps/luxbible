import 'package:bible/models/bible/verse.dart';

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
  final ParagraphType type;

  const VersesParagraph({required this.verses, required this.type});
}

class BreakParagraph extends Paragraph {
  static const BreakParagraph _instance = BreakParagraph._();

  const BreakParagraph._();

  factory BreakParagraph() => _instance;
}

enum SectionType { s1, s2 }

enum ParagraphType { p, q1, q2, li1, li2 }
