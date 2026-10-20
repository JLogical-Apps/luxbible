import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/highlight_icon.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/ui/widgets/annotation_preview.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class HighlightStyleSheet {
  static Future<(HighlightStyle, String label)?> show(
    BuildContext context, {
    (HighlightStyle, String label)? initialStyle,
    required List<(HighlightStyle, String label)> otherStyles,
  }) {
    final style = initialStyle?.$1 ?? HighlightStyle(color: .red, type: .highlight);
    final previewReference = Reference(book: .john, chapterNum: 11, verseNum: 35);

    final port = Port.of({
      'label': PortField.string(initialValue: initialStyle?.$2).isNotBlank(),
      'color': SimplePortField<ColorEnum>(value: style.color),
      'type': SimplePortField<HighlightStyleType>(value: style.type).withValidator(
        Validator(
          (context) =>
              otherStyles.any((entry) => entry.$1 == getStyle(context.port)) ? t.highlightStyleUi.duplicate : null,
        ),
      ),
      'icon': SimplePortField<HighlightIcon?>(value: style.icon),
    });

    // The duplicate error is shown under Style but depends on every style field.
    void clearDuplicateError() => port.clearError(path: 'type');

    return context.showStyledSheet(
      (context, _) => StyledPortSheet(
        title: (initialStyle == null ? t.highlightStyleUi.create : t.highlightStyleUi.edit).toText(),
        bodyPadding: .all(16),
        port: port.map((values, _) => (getStyle(port), (values['label'] as String).trim())),
        // The dock is outside the sheet's PortBuilder, so the preview listens to the port itself.
        aboveButtons: PortBuilder(
          port: port,
          builder: (context, port) => StyledSection.child(
            title: t.labels.preview.toText(),
            padding: .only(top: 16),
            childPadding: .zero,
            child: AnnotationPreview(
              // Covers "wept" in the BSB text.
              selection: BibleTextSelection(
                start: .fromReference(reference: previewReference, characterOffset: 6),
                end: .fromReference(reference: previewReference, characterOffset: 9),
                translation: .bsb,
              ),
              padding: .only(bottom: 24),
              style: getStyle(port),
            ),
          ),
        ),
        childrenBuilder: (context, ref) {
          final style = getStyle(port);
          final hueColor = style.color.toHue(context.colors).primary;
          return [
            StyledPortFieldBuilder<String>(
              fieldPath: 'label',
              builder: (context, value, errorText, onChanged) => StyledTextField(
                text: value,
                label: t.highlightStyleUi.label.toText(),
                error: errorText?.toText(),
                onChanged: onChanged,
              ),
            ),
            StyledPortFieldBuilder<ColorEnum>(
              fieldPath: 'color',
              builder: (context, selectedColor, _, onChanged) => StyledFormInput(
                label: t.labels.color.toText(),
                child: Row(
                  children: ColorEnum.values
                      .map(
                        (color) => Expanded(
                          child: StyledCircleButton.lg(
                            child: SelectableIcon(
                              Symbols.circle,
                              isSelected: color == selectedColor,
                              color: color.toHue(context.colors).primary,
                            ),
                            onPressed: () {
                              onChanged(color);
                              clearDuplicateError();
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            StyledPortFieldBuilder<HighlightStyleType>(
              fieldPath: 'type',
              builder: (context, selectedType, error, onChanged) => StyledFormInput(
                label: t.labels.style.toText(),
                error: error?.toText(),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: HighlightStyleType.values
                      .map(
                        (type) => StyledMaterial(
                          isSelected: type == selectedType,
                          onPressed: () => onChanged(type),
                          padding: .all(8),
                          borderRadius: .circular(8),
                          child: type.buildPreview(context, color: style.color),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            StyledPortFieldBuilder<HighlightIcon?>(
              fieldPath: 'icon',
              builder: (context, selectedIcon, _, onChanged) => StyledFormInput(
                label: t.labels.icon.toText(),
                child: Column(
                  spacing: 12,
                  children: [null, ...HighlightIcon.values]
                      .slices(ColorEnum.values.length)
                      .map(
                        (icons) => Row(
                          mainAxisAlignment: .spaceBetween,
                          children: icons
                              .map(
                                (icon) => StyledMaterial(
                                  isSelected: icon == selectedIcon,
                                  onPressed: () {
                                    onChanged(icon);
                                    clearDuplicateError();
                                  },
                                  padding: .all(8),
                                  borderRadius: .circular(8),
                                  child: SizedBox(
                                    width: 18,
                                    height: 24,
                                    child: Center(
                                      child: Icon(icon?.icon ?? Annotation.noteIcon, size: 18, color: hueColor),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  static HighlightStyle getStyle(Port port) =>
      HighlightStyle(color: port.getByPath('color'), type: port.getByPath('type'), icon: port.getByPath('icon'));
}
