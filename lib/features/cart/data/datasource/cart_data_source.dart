import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/core/services/remote/network_services.dart';
import 'package:nattt_bazaar/features/cart/domain/models/cart_model.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

abstract class CartDataSource {
  ///Get Cart for the user
  Future<Either<AppException, Cart>> getCartForTheUser(String userObjectId);

  ///Add product to the cart for the respective user.
  Future<Either<AppException, Cart>> addProductToCart(
      String userId, Product product, int quantity);
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

  @override
  Future<Either<AppException, Cart>> addProductToCart(
      String userId, Product product, int quantity) async {
    try {
      final eitherResponse = await networkService.post('/cart', data: {
        'user': userId,
        'product': product.toMap(),
        'quantity': quantity
      });

      return eitherResponse.fold((appException) => Left(appException),
          (appResponse) {
        final data = appResponse.data['data'];
        return Right(Cart.fromJson(data));
      });
    } catch (e) {
      return Left(AppException(
        message: 'Unknown Error Occured',
        statusCode: 4,
        identifier: '${e.toString()}\nCartRemoteDataSource.addToCart',
      ));
    }
  }
}
