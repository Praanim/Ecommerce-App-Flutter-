import 'package:nattt_bazaar/features/cart/presentation/providers/notifiers/cart_item_quantity_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///This provider provides the number of the cart items for the user.
final cartItemsCountProvider = StateProvider<int>((ref) => 0);

final cartItemCheckoutDetailsProvider = StateNotifierProvider.autoDispose
    .family<CartItemCheckoutDetailsNotifier, CartItemCheckoutDetails, int>(
        (ref, id) => CartItemCheckoutDetailsNotifier());
