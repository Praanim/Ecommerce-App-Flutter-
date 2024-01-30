import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';

import '../models/product_model.dart';

abstract class ProductReposiotry{

  ///Method to get all Products from the server
  Future<Either<AppException,List<Product>>> getAllProducts();
}