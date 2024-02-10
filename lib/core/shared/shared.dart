import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SharedClass {
  static AppException unknownErrorInstance({required String identifier}) {
    return AppException(
        message: 'Unknown error occurred',
        statusCode: 4,
        identifier: identifier);
  }

  static AppException firebaseErrorInstance(
      {required FirebaseAuthException e}) {
    return AppException(
        message: e.message ?? 'Something went wrong in Firebase Auth',
        statusCode: 2,
        identifier: 'FirebaseAuthException${e.message}');
  }

  static void showMySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some action to be performed when the "Close" button is pressed
        },
      ),
    );

    // Show the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
