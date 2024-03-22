import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final TextInputAction? textInputAction;
  final Widget? trailing;
  final bool? obscureText;
  final bool? readOnly;
  final String? prefixText;
  final TextInputType? keyboardInputType;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      this.textInputAction,
      this.validator,
      this.trailing,
      this.obscureText,
      this.readOnly,
      this.prefixText,
      this.keyboardInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.appTextTheme.bodySmall,
      controller: textEditingController,
      keyboardType: keyboardInputType,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
          labelText: labelText, suffixIcon: trailing, prefixText: prefixText),
      readOnly: readOnly ?? false,
      validator: validator,
    );
  }
}
