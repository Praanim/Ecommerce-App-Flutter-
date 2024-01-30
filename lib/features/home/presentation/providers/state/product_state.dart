import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess({required this.products});
}

class ProductFailure extends ProductState {
  final AppException appException;

  ProductFailure({required this.appException});
}
