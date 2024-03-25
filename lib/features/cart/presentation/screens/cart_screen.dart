import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/custom_app_bar.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/widgets/custom_elevated_button.dart';
import 'package:nattt_bazaar/core/widgets/custom_error_widget.dart';
import 'package:nattt_bazaar/core/widgets/no_content_widget.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/cart_providers.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/notifiers/cart_notifier.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/notifiers/cart_state.dart';
import 'package:nattt_bazaar/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Cart'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(cartNotifierProvider);
          int checkoutAmount = 0;

          if (state is CartSuccess) {
            final cartItems = state.cart.items;
            return cartItems.isEmpty
                ? const NoContentWidget(
                    text: "No Items Found in Cart",
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: ValConstants.value8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = state.cart.items[index];

                              return CartItemWidget(
                                cartItem: cartItem,
                                id: index,
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(
                            ValConstants.value8,
                          ),
                          width: double.infinity,
                          child: CustomElevatedButton(
                            title: 'Checkout',
                            onPressed: () {
                              for (int i = 0;
                                  i < state.cart.items.length;
                                  i++) {
                                checkoutAmount = checkoutAmount +
                                    ref
                                        .read(
                                            cartItemCheckoutDetailsProvider(i))
                                        .price;
                              }

                              print(checkoutAmount);
                              checkoutAmount = 0;
                            },
                            btnStyle: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: ValConstants.value10),
                                backgroundColor:
                                    context.appColorScheme.primary),
                            titleStyle: context.appTextTheme.bodyLarge!
                                .copyWith(
                                    color: context.appColorScheme.onPrimary,
                                    fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  );
          } else {
            return CustomErrorWidget(
                errorMssg: "Could not get the cart items $state");
          }
        },
      ),
    );
  }
}
