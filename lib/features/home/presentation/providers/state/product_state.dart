import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

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
