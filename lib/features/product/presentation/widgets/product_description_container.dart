import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_card.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/product/presentation/widgets/price_tag_widgets.dart';
import 'package:flutter/material.dart';

class ProductDescriptionContainer extends StatelessWidget {
  final Product product;

  const ProductDescriptionContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(ValConstants.value8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.title,
                    style: context.appTextTheme.headlineMedium!
                        .copyWith(color: context.appColorScheme.primary)),
                PriceTag(price: product.price),
              ],
            ),
            VerticalGap.xs,
            //TODO:Can add show more thing
            Text(
              '${product.title} ${TextConstants.loremIpsum}',
              style: context.appTextTheme.displaySmall,
            )
          ],
        ),
      ),
    );
  }
}
