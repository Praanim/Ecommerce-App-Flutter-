import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/home/data/datasource/home_remote_data_source.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/home/domain/repositories/product_repository.dart';

class ProductReposiotryImpl extends ProductReposiotry{
  final HomeDataSource homeDataSource;

  ProductReposiotryImpl({
    required this.homeDataSource
  });

  @override
  Future<Either<AppException, List<Product>>> getAllProducts() {
    return homeDataSource.getAllProducts();
  }
 
  
}