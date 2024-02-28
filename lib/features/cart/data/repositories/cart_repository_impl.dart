import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/cart/data/datasource/cart_data_source.dart';
import 'package:eccomerce_frontend/features/cart/domain/models/cart_model.dart';
import 'package:eccomerce_frontend/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<Either<AppException, Cart>> getCartForUser(String userObjectId) {
    return cartDataSource.getCartForTheUser(userObjectId);
  }
}
