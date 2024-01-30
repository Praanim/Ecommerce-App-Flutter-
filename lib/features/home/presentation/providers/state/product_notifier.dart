
import 'package:eccomerce_frontend/features/home/domain/repositories/product_repository.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<ProductState>{
  final ProductReposiotry productReposiotry;
  ProductNotifier({required this.productReposiotry,}):super(ProductInitial());

  void getAllProducts() async{
    final eitherResponse = await productReposiotry.getAllProducts();
    eitherResponse.fold((appException) {
      state = ProductFailure(appException: appException);
    }, (products) {
      state = ProductSuccess(products: products);
    });
  }
}