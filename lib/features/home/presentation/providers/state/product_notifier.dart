import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/product/domain/models/category_model.dart';
import 'package:eccomerce_frontend/features/product/domain/repositories/product_repository.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductReposiotry productReposiotry;
  ProductNotifier({
    required this.productReposiotry,
  }) : super(ProductInitial());

  List<Product> products = [];
  List<Category> allCategories = [];

  void getAllProducts() async {
    final eitherResponse = await productReposiotry.getAllProducts();
    eitherResponse.fold((appException) {
      state = ProductFailure(appException: appException);
    }, (apiProducts) {
      products = apiProducts;
      state = ProductSuccess(products: products);
    });
  }

  void getAllCategories() async {
    final eitherResponse = await productReposiotry.getAllCategores();
    eitherResponse.fold((appException) {
      state = ProductFailure(appException: appException);
    }, (category) {
      allCategories = category;
    });
  }

  void filterProducts({required String categoryId}) {
    state = ProductInitial();
    final filteredProducts = products.where((product) {
      return product.category == categoryId;
    }).toList();
    state = ProductSuccess(products: filteredProducts);
  }
  // state.products.sort((a, b) => b.createdOn.compareTo(a.createdOn));
}
