import 'package:bible/models/color_enum.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'highlight_style.freezed.dart';
part 'highlight_style.g.dart';

@freezed
sealed class HighlightStyle with _$HighlightStyle {
  static const List<(HighlightStyle, String label)> defaultValues = [
    (HighlightStyle(color: .red, type: .highlight), 'Red'),
    (HighlightStyle(color: .orange, type: .highlight), 'Orange'),
    (HighlightStyle(color: .yellow, type: .highlight), 'Yellow'),
    (HighlightStyle(color: .green, type: .highlight), 'Green'),
    (HighlightStyle(color: .blue, type: .highlight), 'Blue'),
    (HighlightStyle(color: .violet, type: .highlight), 'Violet'),
    (HighlightStyle(color: .stone, type: .straightUnderline), 'Underline'),
    (HighlightStyle(color: .red, type: .wavyUnderline), 'Important'),
  ];

  static const HighlightStyle fallback = HighlightStyle(color: .blue, type: .highlight);

  const HighlightStyle._();

  const factory HighlightStyle({required ColorEnum color, required HighlightStyleType type}) = _HighlightStyle;

  factory HighlightStyle.fromJson(Map<String, dynamic> json) => _$HighlightStyleFromJson(json);
}

enum HighlightStyleType {
  highlight,
  straightUnderline,
  wavyUnderline;

  IconData get icon => switch (this) {
    highlight => Symbols.highlighter_size_3,
    straightUnderline => Symbols.format_underlined,
    wavyUnderline => Symbols.format_underlined_squiggle,
  };

  String get title => switch (this) {
    highlight => 'Highlight',
    straightUnderline => 'Underline',
    wavyUnderline => 'Squiggle',
  };

  Widget buildPreview(BuildContext context, {required ColorEnum color, ComponentSize size = .md}) => SizedBox(
    width: size == .md ? 18 : 12,
    height: size == .md ? 24 : 16,
    child: Stack(
      alignment: .center,
      children: [
        if (this == highlight)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.toHue(context.colors).primary.withValues(alpha: 0.5),
                borderRadius: .circular(4),
              ),
            ),
          ),
        Padding(
          padding: this == highlight ? .only(top: 2) : .zero,
          child: Text(
            'A',
            textAlign: .center,
            style: TextStyle(fontSize: size == .md ? 18 : 12, fontWeight: .w600, height: 1),
          ),
        ),
        if (this != highlight)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 4,
            child: HighlightUnderline(
              color: color.toHue(context.colors).primary,
              wavy: this == wavyUnderline,
              thickness: 3,
            ),
          ),
      ],
    ),
  );
}
