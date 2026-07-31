import 'package:bible/models/color_enum.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:port/port.dart';
import 'package:utils_core/utils_core.dart';

class HighlightStyleSheet {
  static Future<(HighlightStyle, String label)?> show(
    BuildContext context, {
    (HighlightStyle, String label)? initialStyle,
    required List<(HighlightStyle, String label)> otherStyles,
  }) => context.showStyledSheet(
    (context) => StyledPortSheet(
      title: (initialStyle == null ? t.highlightStyleUi.create : t.highlightStyleUi.edit).toText(),
      port: Port.of({
        'label': PortField.string(initialValue: initialStyle?.$2).isNotBlank(),
        'style':
            SimplePortField<HighlightStyle>(
              value: initialStyle?.$1 ?? HighlightStyle(color: .red, type: .highlight),
            ).withValidator(
              Validator(
                (context) =>
                    otherStyles.any((entry) => entry.$1 == context.value) ? t.highlightStyleUi.duplicate : null,
              ),
            ),
      }).map((values, port) => (values['style'] as HighlightStyle, (values['label'] as String).trim())),
      childrenBuilder: (context, ref) => [
        StyledPortFieldBuilder<String>(
          fieldPath: 'label',
          builder: (context, value, errorText, onChanged) => StyledTextField(
            text: value,
            label: t.highlightStyleUi.label.toText(),
            error: errorText?.toText(),
            onChanged: onChanged,
          ),
        ),
        StyledPortFieldBuilder<HighlightStyle>(
          fieldPath: 'style',
          builder: (context, selectedStyle, error, onChanged) => StyledFormInput(
            label: t.labels.style.toText(),
            error: error?.toText(),
            child: Column(
              spacing: 12,
              children: HighlightStyleType.values
                  .map(
                    (type) => Row(
                      mainAxisAlignment: .spaceBetween,
                      children: ColorEnum.values.map((color) {
                        final style = HighlightStyle(color: color, type: type);
                        return StyledMaterial(
                          isSelected: style == selectedStyle,
                          onPressed: () => onChanged(style),
                          padding: .all(8),
                          borderRadius: .circular(8),
                          child: type.buildPreview(context, color: color, size: .md),
                        );
                      }).toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
