import 'package:bible/models/color_enum.dart';
import 'package:bible/models/user/language.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/i18n.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

part 'highlight_style.freezed.dart';
part 'highlight_style.g.dart';

@freezed
sealed class HighlightStyle with _$HighlightStyle {
  static List<(HighlightStyle, String label)> get defaults {
    final translations = Language.device.appLocale.translations.highlightStyles;
    return [
      (HighlightStyle(color: .red, type: .highlight), translations.red),
      (HighlightStyle(color: .orange, type: .highlight), translations.orange),
      (HighlightStyle(color: .yellow, type: .highlight), translations.yellow),
      (HighlightStyle(color: .green, type: .highlight), translations.green),
      (HighlightStyle(color: .blue, type: .highlight), translations.blue),
      (HighlightStyle(color: .violet, type: .highlight), translations.violet),
      (HighlightStyle(color: .stone, type: .straightUnderline), translations.underline),
      (HighlightStyle(color: .red, type: .wavyUnderline), translations.important),
    ];
  }

  static const HighlightStyle fallback = HighlightStyle(color: .red, type: .highlight);

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
    highlight => t.highlightStyles.highlight,
    straightUnderline => t.highlightStyles.underline,
    wavyUnderline => t.highlightStyles.squiggle,
  };

  Widget buildPreview(BuildContext context, {required ColorEnum color, ComponentSize size = .md}) => SizedBox(
    width: switch (size) {
      .lg => 24,
      .md => 18,
      .sm => 12,
    },
    height: switch (size) {
      .lg => 30,
      .md => 24,
      .sm => 16,
    },
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
            style: TextStyle(
              fontSize: switch (size) {
                .lg => 24,
                .md => 18,
                .sm => 12,
              },
              fontWeight: .w600,
              height: 1,
              color: context.colors.contentPrimary,
            ),
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
