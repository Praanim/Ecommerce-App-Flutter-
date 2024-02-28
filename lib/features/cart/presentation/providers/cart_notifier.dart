import 'package:eccomerce_frontend/features/cart/domain/providers/cart_source_providers.dart';
import 'package:eccomerce_frontend/features/cart/domain/repositories/cart_repository.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/cart_providers.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartNotifierProvider = NotifierProvider<CartNotifier, CartState>(() {
  return CartNotifier();
});

class CartNotifier extends Notifier<CartState> {
  late final CartRepository cartRepository;

  @override
  CartState build() {
    cartRepository = ref.watch(cartRepoProvider);
    return CartInitial();
  }

  Future<void> getCartForTheUser() async {
    //TODO:make the user object id dynamic
    final eitherResponse =
        await cartRepository.getCartForUser('64d3147545b3b86639dc1570');

    eitherResponse.fold((appException) {
      state = CartFailure(appException: appException);
    }, (cart) {
      //set the no of items in the cart for the user.
      setCartItems(cart.items.length);
      state = CartSuccess(cart: cart);
    });
  }

  void setCartItems(int cartItemsLength) {
    ref.read(cartItemsCountProvider.notifier).state = cartItemsLength;
  }
}
