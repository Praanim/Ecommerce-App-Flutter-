import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/widgets/custom_error_widget.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/product_providers.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(productNotifierProvider);
            final categories =
                ref.read(productNotifierProvider.notifier).allCategories;

            if (state is ProductSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final categoryName = categories[index].title;
                        return GestureDetector(
                          onTap: () {
                            //filter the product
                            ref
                                .read(productNotifierProvider.notifier)
                                .filterProducts(
                                    categoryId: categories[index].id);
                          },
                          child: Card(child: Center(child: Text(categoryName))),
                        );
                      },
                      itemCount: categories.length,
                    ),
                  ),
                  //list of all products
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of items per row
                              crossAxisSpacing:
                                  AppConstants.pad8, // Spacing between columns
                              mainAxisSpacing:
                                  AppConstants.pad8, // Spacing between rows
                              mainAxisExtent: 300),
                      //TODO:make the 300 value responsive
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = state.products[index];
                        return ProductCard(
                          product: product,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProductInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const CustomErrorWidget(
                errorMssg: 'Something is wrong',
              );
            }
          },
        ));
  }
}
