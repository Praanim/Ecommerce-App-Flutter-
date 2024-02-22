import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/core/utils/custom_error_widget.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/product_providers.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
        ),
        //TODO:Add filters like in Deardoc Faqs
        body: Builder(
          builder: (context) {
            final state = ref.watch(productNotifierProvider);
            final categories =
                ref.read(productNotifierProvider.notifier).allCategories;

            if (state is ProductSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: 100,
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
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.amber.shade300, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(categoryName),
                            ),
                          ),
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
            } else {
              return Text('Something went wrong');
            }
          },
        ));
  }
}
