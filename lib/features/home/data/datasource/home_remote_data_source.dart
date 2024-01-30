import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/network_services.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';

abstract class HomeDataSource {
  Future<Either<AppException, List<Product>>> getAllProducts();
}

class HomeRemoteDataSource extends HomeDataSource {
  final NetworkService networkService;

  HomeRemoteDataSource({required this.networkService});

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
          identifier: '${e.toString()}\nHomeRemoteDataSource.getAllProducts',
        ),
      );
    }
  }
}
