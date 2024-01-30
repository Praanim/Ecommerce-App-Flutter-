import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  
  final TextEditingController textEditingController;
  final String labelText;
  const CustomTextFormField({super.key, required this.textEditingController, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: labelText,
              ),
            );
  }
}