import 'package:eccomerce_frontend/core/widgets/custom_error_widget.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/cart_notifier.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/cart_state.dart';
import 'package:flutter/material.dart';
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

          if (state is CartSuccess) {
            return ListView.builder(
              itemCount: state.cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = state.cart.items[index];

                return Text(cartItem.product.title);
              },
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
