import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/product_providers.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/custom_carousel_slider.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_card.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_filter_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCarouselSlider(),
            VerticalGap.s,
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstants.pad8),
              child: Consumer(builder: (context, ref, child) {
                final state = ref.watch(productNotifierProvider);
                final sizedBoxHeight = context.screenHeight / 3;
                if (state is ProductSuccess) {
                  //get recently added products
                  final recentlyAddedProducts = ref
                      .read(productNotifierProvider.notifier)
                      .getRecentlyAddedProducts();

                  //get top sales product
                  final getTopSalesProduct = ref
                      .read(productNotifierProvider.notifier)
                      .getTopSalesProducts();

                  return Column(
                    children: [
                      //Recently added products
                      SizedBox(
                        height: sizedBoxHeight,
                        child: Column(
                          children: [
                            ProductFilterRow(
                              title: 'Recently Added',
                              onTap: () {
                                context.goNamed(RouteConstants.productScreen);
                              },
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: recentlyAddedProducts.length,
                                itemBuilder: (context, index) {
                                  final product = recentlyAddedProducts[index];

                                  return ProductCard(product: product);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalGap.s,
                      //Top sales products
                      SizedBox(
                        height: sizedBoxHeight,
                        child: Column(
                          children: [
                            ProductFilterRow(
                              title: 'Top Sales',
                              onTap: () {},
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: getTopSalesProduct.length,
                                itemBuilder: (context, index) {
                                  final product = getTopSalesProduct[index];

                                  return ProductCard(product: product);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is ProductFailure) {
                  return Text(state.appException.identifier);
                } else {
                  //TODO:make it common widget
                  return const CircularProgressIndicator();
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
