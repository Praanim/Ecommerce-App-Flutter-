import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';

abstract class OrderRepository {
  ///creates order for the user.
  Future<Either<AppException, OrderModel>> createOrder(OrderModel orderModel);

  ///creates order for the user.
  Future<Either<AppException, List<OrderModel>>> getUserOrder(String userId);
}
