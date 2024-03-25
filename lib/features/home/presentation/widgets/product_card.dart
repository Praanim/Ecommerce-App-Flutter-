import 'package:cached_network_image/cached_network_image.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/routes/route_constants.dart';
import 'package:nattt_bazaar/core/shared/shared.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  ///[Product] details model
  final Product product;

  ///on Product card tap event.
  final void Function()? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(RouteConstants.productDetailsScreen,
            extra: {'product': product});
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: context.appColorScheme.primary,
        child: SizedBox(
          // height: MediaQuery.of(context).size.height/ 3,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              SharedClass.checkAvailableProductImage(product)),
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.pad4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: context.appTextTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Rs.${product.price}',
                          style: context.appTextTheme.displayMedium,
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
