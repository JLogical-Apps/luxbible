import 'dart:math';

import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledTextField extends HookWidget {
  final String text;
  final Function(TextEditingValue)? onTextEditValueChanged;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  final String? suggestedText;
  final String? hintText;

  final bool autofocus;
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
    this.hintText,
    this.suggestedText,
    this.autofocus = false,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.action,
    this.autofillHints,
    this.inputFormatters = const [],
    this.focusNode,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ?? context.textStyle.paragraphMedium;

    final focusNode = useListenable(this.focusNode ?? useFocusNode());
    final controller = useTextEditingController(text: text);

    if (text != controller.text) {
      final isAtEnd =
          controller.text.length + 1 == text.length &&
          controller.selection.baseOffset + 1 == text.length;
      final offset = isAtEnd
          ? text.length
          : min(text.length, controller.selection.baseOffset);

      controller.value = controller.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: offset),
      );
    }

    useOnFocusNodeFocused(
      focusNode,
      () => controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.value.text.length,
      ),
    );

    final suggestedText = this.suggestedText;
    final remainingSuggestedText =
        suggestedText == null || text.length > suggestedText.length
        ? null
        : suggestedText.substring(text.length);

    return Stack(
      children: [
        if (focusNode.hasPrimaryFocus &&
            onChanged != null &&
            remainingSuggestedText != null)
          Positioned.fill(
            child: Padding(
              padding:
                  EdgeInsets.all(12) +
                  EdgeInsets.only(left: 6 + textStyle.getWidth(text)),
              child: Text(remainingSuggestedText, style: textStyle.subtle(context)),
            ),
          ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          onChanged: (text) {
            onTextEditValueChanged?.call(controller.value);
            onChanged?.call(text);
          },
          enabled: onChanged != null,
          autofocus: autofocus,
          style: textStyle.disabled(context, isDisabled: onChanged == null),
          keyboardType: textInputType,
          textInputAction: action,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          onSubmitted: onSubmit,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            fillColor: onChanged == null
                ? context.colors.surfaceDisabled
                : context.colors.surfaceSecondary,
            filled: !focusNode.hasPrimaryFocus,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: context.textStyle.paragraphMedium
                .subtle(context)
                .disabled(context, isDisabled: onChanged == null),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colors.borderSelected, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
