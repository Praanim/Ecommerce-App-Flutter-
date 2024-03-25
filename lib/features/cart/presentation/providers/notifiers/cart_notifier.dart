import 'package:nattt_bazaar/features/cart/domain/providers/cart_source_providers.dart';
import 'package:nattt_bazaar/features/cart/domain/repositories/cart_repository.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/cart_providers.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/notifiers/cart_state.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
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

  Future<void> getCartForTheUser(String userId) async {
    final eitherResponse = await cartRepository.getCartForUser(userId);

    eitherResponse.fold((appException) {
      state = CartFailure(appException: appException);
    }, (cart) {
      //set the no of items in the cart for the user.
      setCartItems(cart.items.length);
      state = CartSuccess(cart: cart);
    });
  }

  Future<void> addProductToCart(
      String userId, Product product, int quantity) async {
    state = CartLoading();
    final eitherResponse =
        await cartRepository.addProductToCart(userId, product, quantity);

    eitherResponse.fold((appException) {
      state = CartFailure(appException: appException);
    }, (cart) async {
      setCartItems(cart.items.length);
      state = CartSuccess(cart: cart);
    });
  }

  void setCartItems(int cartItemsLength) {
    ref.read(cartItemsCountProvider.notifier).state = cartItemsLength;
  }
}
