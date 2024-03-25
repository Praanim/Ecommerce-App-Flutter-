import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/shared.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/features/cart/domain/models/cart_model.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemWidget extends StatelessWidget {
  final int id;

  ///Takes cart item [Item].
  final Item cartItem;

  const CartItemWidget({super.key, required this.cartItem, required this.id});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppConstants.primaryBorderRadius),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          SharedClass.checkAvailableProductImage(
                              cartItem.product)))),
            ),
            HorizontalGap.xl,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: context.appTextTheme.headlineSmall,
                  ),
                  VerticalGap.m,
                  Consumer(builder: (context, ref, child) {
                    final cartItemCheckoutDetails =
                        ref.watch(cartItemCheckoutDetailsProvider(id));
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Implement buttons or text field to modify quantity
                        Row(
                          children: [
                            AddSubractButton(
                              iconData: Icons.remove,
                              onTap: () {
                                ref
                                    .read(cartItemCheckoutDetailsProvider(id)
                                        .notifier)
                                    .decreaseQuantity(cartItem.product.price);
                              },
                            ),
                            HorizontalGap.s,
                            Text(cartItemCheckoutDetails.quantity.toString()),
                            HorizontalGap.s,
                            AddSubractButton(
                              iconData: Icons.add,
                              onTap: () {
                                ref
                                    .read(cartItemCheckoutDetailsProvider(id)
                                        .notifier)
                                    .increaseQuantity(cartItem.product.price);
                              },
                            ),
                          ],
                        ),

                        Text('Rs.${cartItemCheckoutDetails.price}'),
                      ],
                    );
                  }),
                  VerticalGap.s,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddSubractButton extends StatelessWidget {
  final IconData iconData;

  final void Function()? onTap;

  const AddSubractButton({
    super.key,
    required this.iconData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ValConstants.value2),
      decoration: BoxDecoration(
          color: context.appColorScheme.primary, shape: BoxShape.circle),
      child: InkWell(
          onTap: onTap,
          child: Icon(
            iconData,
            color: context.appColorScheme.onPrimary,
            size: ValConstants.value20,
          )),
    );
  }
}
