import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_error_widget.dart';
import 'package:eccomerce_frontend/features/cart/domain/models/cart_model.dart';
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

                return CartItemWidget(cartItem: cartItem);
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

class CartItemWidget extends StatelessWidget {
  ///Takes cart item [Item].
  final Item cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          left: AppConstants.pad12,
          right: AppConstants.pad12,
          bottom: AppConstants.pad8),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.pad8),
        child: Row(
          children: [
            Image.network(ImageConstants.randomNetworkImageUrl,
                height: 80, width: 80),
            HorizontalGap.s,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.title),
                  Text('Rs.${cartItem.product.price}'),
                  Row(
                    children: [
                      // Implement buttons or text field to modify quantity
                      const Text('Quantity:1'),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // Call cart provider method to remove item
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
