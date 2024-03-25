import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
import 'package:nattt_bazaar/features/product/data/datasource/product_data_source.dart';
import 'package:nattt_bazaar/features/product/domain/models/category_model.dart';
import 'package:nattt_bazaar/features/product/domain/repositories/product_repository.dart';

class ProductReposiotryImpl extends ProductReposiotry {
  final ProductDataSource productDataSource;

  ProductReposiotryImpl({required this.productDataSource});

  @override
  Future<Either<AppException, List<Product>>> getAllProducts() {
    return productDataSource.getAllProducts();
  }

  @override
  Future<Either<AppException, List<Category>>> getAllCategores() {
    return productDataSource.getAllCategores();
  }
}
