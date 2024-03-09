import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/core/widgets/custom_error_widget.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/cart_providers.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/notifiers/cart_notifier.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/notifiers/cart_state.dart';
import 'package:eccomerce_frontend/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(cartNotifierProvider);
          int checkoutAmount = 0;

          if (state is CartSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cart.items.length,
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
                      for (int i = 0; i < state.cart.items.length; i++) {
                        checkoutAmount = checkoutAmount +
                            ref.read(cartItemCheckoutDetailsProvider(i)).price;
                      }

                      print(checkoutAmount);
                      checkoutAmount = 0;
                    },
                    btnStyle: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: ValConstants.value10),
                        backgroundColor: context.appColorScheme.primary),
                    titleStyle: context.appTextTheme.bodyLarge!.copyWith(
                        color: context.appColorScheme.onPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
