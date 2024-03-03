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

  //this will get initialized when the notifier gets initialized.
  List<Product> _allProducts = [];
  List<Category> allCategories = [];

  void getAllProducts() async {
    final eitherResponse = await productReposiotry.getAllProducts();
    eitherResponse.fold((appException) {
      state = ProductFailure(appException: appException);
    }, (apiProducts) {
      _allProducts = apiProducts;
      state = ProductSuccess(products: _allProducts);
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
    final filteredProducts = _allProducts.where((product) {
      return product.category == categoryId;
    }).toList();
    state = ProductSuccess(products: filteredProducts);
  }

  List<Product> getRecentlyAddedProducts({int limit = 5}) {
    if (state is ProductSuccess && _allProducts.isNotEmpty) {
      final tempList = _allProducts;
      tempList.sort((a, b) => b.createdOn.compareTo(a.createdOn));

      // Take only the first 'limit' number of products
      return tempList.take(limit).toList();
    } else {
      return [];
    }
  }

  List<Product> getTopSalesProducts({int limit = 5}) {
    if (state is ProductSuccess && _allProducts.isNotEmpty) {
      final tempList = _allProducts;
      try {
        tempList.sort(
            (a, b) => b.sales!.quantitySold.compareTo(a.sales!.quantitySold));
      } catch (e) {
        return [];
      }

      // Take only the first 'limit' number of products
      return tempList.take(limit).toList();
    } else {
      return [];
    }
  }
}
