import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/cart/domain/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final Cart cart;

  CartSuccess({required this.cart});
}

class CartFailure extends CartState {
  final AppException appException;

  CartFailure({required this.appException});
}
