import 'package:eccomerce_frontend/core/constants/button_style_constants.dart';
import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/core/widgets/custom_error_widget.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/product_providers.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_card.dart';
import 'package:eccomerce_frontend/features/product/domain/models/category_model.dart';
import 'package:eccomerce_frontend/features/product/presentation/providers/selected_product_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text('Products'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(productNotifierProvider);
            final categories =
                ref.read(productNotifierProvider.notifier).allCategories;

            if (state is ProductSuccess) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ValConstants.value6),
                child: Column(
                  children: [
                    ProductFilterTags(categories: categories),
                    //list of all products
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of items per row
                                crossAxisSpacing: AppConstants
                                    .pad8, // Spacing between columns
                                mainAxisSpacing:
                                    AppConstants.pad8, // Spacing between rows
                                mainAxisExtent: 280),
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
                ),
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

class ProductFilterTags extends ConsumerWidget {
  const ProductFilterTags({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedProductCategoryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ValConstants.value6),
      child: SizedBox(
        height: 45,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final categoryName = categories[index].title;
            final categoryId = categories[index].id;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ValConstants.value4),
              child: CustomElevatedButton(
                  title: categoryName,
                  onPressed: () {
                    //choose selected category
                    ref
                        .read(selectedProductCategoryProvider.notifier)
                        .selectCategory(categoryId);

                    if (selectedCategory != categoryId) {
                      //filter the product(product Notifier)
                      ref
                          .read(productNotifierProvider.notifier)
                          .filterProducts(categoryId: categories[index].id);
                    }
                  },
                  titleStyle: context.appTextTheme.displaySmall!.copyWith(
                      color: selectedCategory == categoryId
                          ? context.appColorScheme.onPrimary
                          : context.appColorScheme.primary),
                  btnStyle: selectedCategory == categoryId
                      ? null
                      : CustomBtnStyle.secondaryBtnStyle(
                          context,
                        )),
            );
            // Container(
            //   margin: const EdgeInsets.symmetric(
            //       horizontal: ValConstants.value4,
            //       vertical: ValConstants.value2),
            //   padding: const EdgeInsets.all(ValConstants.value8),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(
            //           AppConstants.primaryBorderRadius),
            //       color: context.appColorScheme.primary),
            //   child: Center(
            //     child: Text(
            //       categoryName,
            //       style: context.appTextTheme.displayMedium!
            //           .copyWith(
            //               color: context.appColorScheme.onPrimary),
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
