import 'package:bible/models/color_enum.dart';
import 'package:bible/models/highlight_icon.dart';
import 'package:bible/models/user/language.dart';
import 'package:bible/ui/widgets/highlight_decoration.dart';
import 'package:bible/ui/widgets/highlight_glyph.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  const factory HighlightStyle({required ColorEnum color, required HighlightStyleType type, HighlightIcon? icon}) =
      _HighlightStyle;

  factory HighlightStyle.fromJson(Map<String, dynamic> json) => _$HighlightStyleFromJson(json);
}

enum HighlightStyleType {
  highlight,
  outline,
  straightUnderline,
  dashedUnderline,
  doubleUnderline,
  wavyUnderline,
  transparent;

  Widget buildPreview(
    BuildContext context, {
    required ColorEnum color,
    HighlightIcon? icon,
    ComponentSize size = .md,
    bool invertContent = false,
  }) {
    final hueColor = color.toHue(context.colors).primary;
    return SizedBox(
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
          Positioned.fill(
            child: HighlightDecoration(type: this, color: hueColor, thickness: 3),
          ),
          Padding(
            padding: this == highlight || this == outline ? .only(top: 2) : .zero,
            child: HighlightGlyph(
              icon: icon,
              size: size,
              invertContent: invertContent,
              color: this == transparent && icon != null ? hueColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
