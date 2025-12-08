import 'dart:math';

import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/style/widgets/styled_form_input.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledTextField extends HookWidget {
  final String text;
  final Function(TextEditingValue)? onTextEditValueChanged;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  final String? labelText;
  final String? suggestedText;
  final String? hintText;
  final String? errorText;

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
    this.labelText,
    this.hintText,
    this.suggestedText,
    this.errorText,
    this.autofocus = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
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
    this.labelText,
    this.hintText,
    this.suggestedText,
    this.errorText,
    this.autofocus = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.textInputType = TextInputType.multiline,
    this.textCapitalization = TextCapitalization.sentences,
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

    final errorText = this.errorText;
    final hasError = errorText != null;

    return StyledFormInput(
      labelText: labelText,
      errorText: errorText,
      child: Stack(
        children: [
          if (focusNode.hasPrimaryFocus && onChanged != null && remainingSuggestedText != null)
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(12) + EdgeInsets.only(left: 6 + textStyle.getWidth(text)),
                child: Text(remainingSuggestedText, style: textStyle.subtle(context)),
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
                  : hasError
                  ? context.colors.surfaceError
                  : context.colors.surfaceSecondary,
              filled: !focusNode.hasPrimaryFocus,
              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
              hintText: hintText,
              hintStyle: context.textStyle.paragraphMd.subtle(context).disabled(context, isDisabled: onChanged == null),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? context.colors.borderError : context.colors.borderSelected,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
