import 'package:eccomerce_frontend/features/cart/presentation/providers/notifiers/cart_item_quantity_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///This provider provides the number of the cart items for the user.
final cartItemsCountProvider = StateProvider<int>((ref) => 0);

final cartItemCheckoutDetailsProvider = StateNotifierProvider.family<
    CartItemQuantityNotifier,
    CartItemCheckoutDetails,
    int>((ref, id) => CartItemQuantityNotifier());
