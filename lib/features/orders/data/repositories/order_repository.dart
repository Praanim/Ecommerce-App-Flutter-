import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';

abstract class OrderRepository {
  ///creates order for the user.
  Future<Either<AppException, OrderModel>> createOrder(OrderModel orderModel);

  ///creates order for the user.
  Future<Either<AppException, List<OrderModel>>> getUserOrder(String userId);
}
