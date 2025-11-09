import 'dart:math';

import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledTextField extends HookWidget {
  final String text;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  final String? hintText;

  final bool autofocus;
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
    this.onChanged,
    this.onSubmit,
    this.hintText,
    this.autofocus = false,
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

    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (text) => onChanged?.call(text),
      enabled: onChanged != null,
      autofocus: autofocus,
      style: textStyle.disabled(context, isDisabled: onChanged == null),
      keyboardType: textInputType,
      textInputAction: action,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      onSubmitted: onSubmit,
      decoration: InputDecoration(
        fillColor: onChanged == null
            ? context.colors.surfaceDisabled
            : context.colors.surfaceSecondary,
        filled: !focusNode.hasPrimaryFocus,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: context.textStyle.paragraphMedium
            .subtle(context)
            .disabled(context, isDisabled: onChanged == null),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colors.borderSelected, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
