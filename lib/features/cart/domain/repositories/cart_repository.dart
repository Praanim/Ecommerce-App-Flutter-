import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/cart/domain/models/cart_model.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

abstract class CartRepository {
  ///Get cart for the respective user using id
  Future<Either<AppException, Cart>> getCartForUser(String userObjectId);

  ///Add product to the cart for the respective user
  Future<Either<AppException, Cart>> addProductToCart(
      String userId, Product product, int quantity);
}
