import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_card.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/product/presentation/providers/product_details_show_more_provider.dart';
import 'package:eccomerce_frontend/features/product/presentation/widgets/price_tag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

            //consumer widget
            Consumer(builder: (context, ref, child) {
              final isShowingMore = ref.watch(showMoreProvider);
              return Column(
                children: [
                  Text(
                    '${product.title} ${TextConstants.loremIpsum}',
                    style: context.appTextTheme.displaySmall,
                    maxLines: isShowingMore ? null : 5,
                  ),
                  VerticalGap.xs,

                  //button to show more/show less
                  InkWell(
                    onTap: () {
                      ref.read(showMoreProvider.notifier).state =
                          !isShowingMore;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          isShowingMore ? 'Show Less' : 'Show More',
                          style: context.appTextTheme.displayMedium!
                              .copyWith(color: context.appColorScheme.primary),
                        ),
                        HorizontalGap.xs,
                        Icon(isShowingMore
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
