import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/cart/data/datasource/cart_data_source.dart';
import 'package:nattt_bazaar/features/cart/domain/models/cart_model.dart';
import 'package:nattt_bazaar/features/cart/domain/repositories/cart_repository.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

class CartRepositoryImpl extends CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<Either<AppException, Cart>> getCartForUser(String userObjectId) {
    return cartDataSource.getCartForTheUser(userObjectId);
  }

  @override
  Future<Either<AppException, Cart>> addProductToCart(
      String userId, Product product, int quantity) {
    return cartDataSource.addProductToCart(userId, product, quantity);
  }
}
