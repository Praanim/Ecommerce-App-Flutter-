import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
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

  //this method checks if in the product model there is availability of the image or not .
  static String checkAvailableProductImage(Product product) {
    return product.images.isNotEmpty
        ? product.images[0]
        : ImageConstants.randomNetworkImageUrl;
  }
}
