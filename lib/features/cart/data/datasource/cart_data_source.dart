import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/network_services.dart';
import 'package:eccomerce_frontend/features/cart/domain/models/cart_model.dart';

abstract class CartDataSource {
  ///Get Cart for the user
  Future<Either<AppException, Cart>> getCartForTheUser(String userObjectId);
}

class CartRemoteDataSource extends CartDataSource {
  final NetworkService networkService;

  CartRemoteDataSource({required this.networkService});

  @override
  Future<Either<AppException, Cart>> getCartForTheUser(
      String userObjectId) async {
    try {
      final eitherResponse = await networkService.get('/cart/$userObjectId');

      return eitherResponse.fold((appException) => Left(appException),
          (appResponse) {
        final data = appResponse.data['data'] as Map<String, dynamic>;

        return Right(Cart.fromJson(data));
      });
    } catch (e) {
      return Left(AppException(
        message: 'Unknown Error Occured',
        statusCode: 4,
        identifier: '${e.toString()}\nCartRemoteDataSource.getAllProducts',
      ));
    }
  }
}
