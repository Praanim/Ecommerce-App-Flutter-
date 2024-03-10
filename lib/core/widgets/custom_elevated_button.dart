import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/themes/app_colors.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;

  final TextStyle? titleStyle;

  ///function to be called on Tap or onPressed.
  final void Function() onPressed;

  ///button style
  final ButtonStyle? btnStyle;

  const CustomElevatedButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.titleStyle,
      this.btnStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: btnStyle ??
            ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(ValConstants.value16),
                backgroundColor: context.appColorScheme.primary),
        child: Text(title,
            style: titleStyle ?? context.appTextTheme.displayMedium));
  }
}
