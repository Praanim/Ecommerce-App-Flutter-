import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/themes/app_colors.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomBtnStyle {
  static ButtonStyle secondaryBtnStyle(
    BuildContext context,
  ) {
    return ElevatedButton.styleFrom(
        backgroundColor: DarkColor.secondaryColor,
        padding: const EdgeInsets.all(ValConstants.value16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ValConstants.value24),
            side:
                BorderSide(color: context.appColorScheme.primary, width: 2.0)));
  }
}
