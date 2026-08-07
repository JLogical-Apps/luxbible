import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';
import 'package:style/src/widgets/styled_form_input.dart';

class StyledTextField extends HookWidget {
  final String text;
  final Function(TextEditingValue)? onTextEditValueChanged;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  final Widget? label;
  final String? suggestedText;
  final String? hintText;
  final Widget? error;

  final int? maxLines;

  final bool autofocus;
  final bool autocorrect;
  final bool readOnly;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final TextInputAction? action;
  final List<String>? autofillHints;
  final List<TextInputFormatter> inputFormatters;

  final FocusNode? focusNode;

  final TextStyle? textStyle;

  const StyledTextField({
    super.key,
    required this.text,
    this.onTextEditValueChanged,
    this.onChanged,
    this.onSubmit,
    this.label,
    this.hintText,
    this.suggestedText,
    this.error,
    this.autofocus = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.textInputType = .text,
    this.textCapitalization = .sentences,
    this.action,
    this.autofillHints,
    this.inputFormatters = const [],
    this.focusNode,
    this.textStyle,
  }) : maxLines = 1;

  const StyledTextField.multiline({
    super.key,
    required this.text,
    this.onTextEditValueChanged,
    this.onChanged,
    this.onSubmit,
    this.label,
    this.hintText,
    this.suggestedText,
    this.error,
    this.autofocus = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.textInputType = .multiline,
    this.textCapitalization = .sentences,
    this.action,
    this.autofillHints,
    this.inputFormatters = const [],
    this.focusNode,
    this.textStyle,
  }) : maxLines = 4;

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ?? context.textStyle.paragraphMd;

    final focusNode = useListenable(this.focusNode ?? useFocusNode());
    final controller = useTextEditingController(text: text);

    useOnListenableChange(
      controller,
      () => WidgetsBinding.instance.addPostFrameCallback((_) => onTextEditValueChanged?.call(controller.value)),
    );

    if (text != controller.text) {
      final isAtEnd = controller.text.length + 1 == text.length && controller.selection.baseOffset + 1 == text.length;
      final offset = isAtEnd ? text.length : min(text.length, controller.selection.baseOffset);

      controller.value = controller.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: offset),
      );
    }

    useOnFocusNodeFocused(
      focusNode,
      () => controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.value.text.length),
    );

    final suggestedText = this.suggestedText;
    final remainingSuggestedText = suggestedText == null || text.length > suggestedText.length
        ? null
        : suggestedText.substring(text.length);

    final error = this.error;
    final hasError = error != null;

    return StyledFormInput(
      label: label,
      error: error,
      child: Stack(
        children: [
          if (focusNode.hasPrimaryFocus && onChanged != null && remainingSuggestedText != null)
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(12) + .only(left: 6 + textStyle.getWidth(text)),
                child: Text(remainingSuggestedText, style: textStyle.subtle()),
              ),
            ),
          TextField(
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly,
            onChanged: (text) => onChanged?.call(text),
            autocorrect: autocorrect,
            enabled: onChanged != null,
            maxLines: maxLines,
            autofocus: autofocus,
            style: textStyle.disabled(isDisabled: onChanged == null),
            keyboardType: textInputType,
            textInputAction: action,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            onSubmitted: (_) => onSubmit?.call(text),
            decoration: InputDecoration(
              contentPadding: .all(12),
              fillColor: onChanged == null
                  ? context.colors.surfaceDisabled
                  : hasError
                  ? context.colors.surfaceCritical
                  : context.colors.surfaceSecondary,
              filled: !focusNode.hasPrimaryFocus,
              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: .circular(8)),
              hintText: hintText,
              hintStyle: context.textStyle.paragraphMd.subtle().disabled(isDisabled: onChanged == null),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? context.colors.borderError : context.colors.borderSelected,
                  width: 3,
                ),
                borderRadius: .circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
