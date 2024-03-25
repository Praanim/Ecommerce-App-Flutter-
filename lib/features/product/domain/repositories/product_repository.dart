import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/product/domain/models/category_model.dart';

import '../../../home/domain/models/product_model.dart';

abstract class ProductReposiotry {
  ///Method to get all Products from the server
  Future<Either<AppException, List<Product>>> getAllProducts();

  ///get all categories
  Future<Either<AppException, List<Category>>> getAllCategores();
}
