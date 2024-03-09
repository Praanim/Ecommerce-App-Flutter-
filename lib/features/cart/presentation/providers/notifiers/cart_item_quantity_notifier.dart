import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemCheckoutDetails {
  final int quantity;
  final int price;

  CartItemCheckoutDetails({required this.quantity, required this.price});

  static CartItemCheckoutDetails initialState() {
    return CartItemCheckoutDetails(quantity: 0, price: 0);
  }

  CartItemCheckoutDetails copyWith({int? quantity, int? price}) {
    return CartItemCheckoutDetails(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

class CartItemQuantityNotifier extends StateNotifier<CartItemCheckoutDetails> {
  CartItemQuantityNotifier() : super(CartItemCheckoutDetails.initialState());

  void increaseQuantity(int itemPrice) {
    final newQuantity = state.quantity + 1;
    final newPrice = _calculateMoney(newQuantity, itemPrice);
    state = state.copyWith(quantity: newQuantity, price: newPrice);
  }

  int _calculateMoney(int itemCount, int itemPrice) {
    return itemCount * itemPrice;
  }

  void decreaseQuantity(int itemPrice) {
    if (state.quantity == 1) {
      return;
    }
    final newQuantity = state.quantity - 1;
    final newPrice = _calculateMoney(newQuantity, itemPrice);
    state = state.copyWith(quantity: newQuantity, price: newPrice);
  }
}
