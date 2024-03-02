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
  ///get texttheme extension
  TextTheme get appTextTheme => Theme.of(this).textTheme;

  ///get screen height extension
  double get screenHeight => MediaQuery.of(this).size.height;

  ///card theme extension
  CardTheme get cardTheme => Theme.of(this).cardTheme;

  ///get color scheme of the app
  ColorScheme get appColorScheme => Theme.of(this).colorScheme;

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
