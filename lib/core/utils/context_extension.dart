import 'package:flutter/material.dart';

///[ToastType]

enum ToastType {
  ///Success
  success,

  ///Error
  error,

  ///Message
  message
}

///Helper Extension
extension HelperExtension on BuildContext {
  ///card theme extension
  CardTheme get cardTheme => Theme.of(this).cardTheme;

  ///SnackBar Extension
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required String message, required ToastType toastType}) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: toastType == ToastType.message
          ? Colors.black
          : toastType == ToastType.success
              ? Colors.green
              : Colors.red,
    ));
  }
}
