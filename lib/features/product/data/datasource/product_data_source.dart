import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/remote.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/product/domain/models/category_model.dart';

abstract class ProductDataSource {
  ///get all Products
  Future<Either<AppException, List<Product>>> getAllProducts();

  ///get all the categories
  Future<Either<AppException, List<Category>>> getAllCategores();
}

class ProductRemoteDataSource extends ProductDataSource {
  final NetworkService networkService;

  ProductRemoteDataSource({required this.networkService});

  @override
  Future<Either<AppException, List<Product>>> getAllProducts() async {
    try {
      final eitherResponse = await networkService.get('/product');

      return eitherResponse.fold((appException) => Left(appException),
          (appResponse) {
        final data = appResponse.data['data'] as List;
        return Right(data.map((product) => Product.fromJson(product)).toList());
      });
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 4,
          identifier: '${e.toString()}\nProductRemoteDataSource.getAllProducts',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<Category>>> getAllCategores() async {
    try {
      final eitherResponse = await networkService.get('/category');

      return eitherResponse.fold((appException) => Left(appException),
          (appResponse) {
        final data = appResponse.data['data'] as List;
        return Right(
            data.map((category) => Category.fromJson(category)).toList());
      });
    } catch (e) {
      return Left(SharedClass.unknownErrorInstance(
          identifier:
              '${e.toString()}\nProductRemoteDataSource.getAllCategories'));
    }
  }
}
