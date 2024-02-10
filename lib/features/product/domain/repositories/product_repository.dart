import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/product/domain/models/category_model.dart';

import '../../../home/domain/models/product_model.dart';

abstract class ProductReposiotry {
  ///Method to get all Products from the server
  Future<Either<AppException, List<Product>>> getAllProducts();

  ///get all categories
  Future<Either<AppException, List<Category>>> getAllCategores();
}
