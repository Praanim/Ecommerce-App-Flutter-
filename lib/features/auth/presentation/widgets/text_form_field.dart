import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final TextInputAction? textInputAction;
  final Widget? trailing;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      this.textInputAction,
      this.validator,
      this.trailing,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.appTextTheme.bodySmall,
      controller: textEditingController,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: trailing,
      ),
      validator: validator,
    );
  }
}
