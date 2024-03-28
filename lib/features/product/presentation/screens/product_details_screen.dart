import 'package:cached_network_image/cached_network_image.dart';
import 'package:nattt_bazaar/core/constants/button_style_constants.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/shared.dart';
import 'package:nattt_bazaar/core/utils/common_app_navigations.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/core/widgets/custom_elevated_button.dart';
import 'package:nattt_bazaar/core/widgets/image_container.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/notifiers/cart_notifier.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
import 'package:nattt_bazaar/features/product/presentation/widgets/product_description_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatelessWidget {
  ///Individual Product Model
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageContainer(
                image: CachedNetworkImageProvider(
                    SharedClass.checkAvailableProductImage(product)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.pad16,
                    vertical: AppConstants.pad32),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const CircleAvatar(
                    radius: ValConstants.value20,
                    child: Icon(
                      IconConstants.backArrow,
                      size: IconConstants.iconPrimarySize,
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalGap.s,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.pad8),
            child: ProductDescriptionContainer(product: product),
          ),
          VerticalGap.l,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer(builder: (context, ref, child) {
                return CustomElevatedButton(
                  title: 'Add to cart',
                  onPressed: () async {
                    //TODO:make quantity dynamicx
                    await ref
                        .read(cartNotifierProvider.notifier)
                        .addProductToCart(
                            ref.read(userDataProvider)!.id!, product, 1)
                        .then((_) {
                      context.showSnackBar(
                          message: 'Product Successfully Added to Cart',
                          toastType: ToastType.success);
                      context.pop();
                    });
                  },
                  titleStyle: context.appTextTheme.displaySmall!
                      .copyWith(color: context.appColorScheme.primary),
                  btnStyle: CustomBtnStyle.secondaryBtnStyle(context),
                );
              }),
              CustomElevatedButton(
                title: 'Buy Now',
                onPressed: () {
                  navigateToCheckoutPage(context, product, 1);
                },
              )
            ],
          ),
          VerticalGap.s,
        ],
      ),
    ));
  }
}
