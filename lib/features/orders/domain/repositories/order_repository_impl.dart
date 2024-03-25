import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/orders/data/datasource/orders_data_source.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';
import 'package:nattt_bazaar/features/orders/data/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrdersDataSource ordersDataSource;

  OrderRepositoryImpl({required this.ordersDataSource});

  @override
  Future<Either<AppException, OrderModel>> createOrder(OrderModel orderModel) {
    return ordersDataSource.createOrder(orderModel);
  }

  @override
  Future<Either<AppException, List<OrderModel>>> getUserOrder(String userId) {
    return ordersDataSource.getUserOrders(userId);
  }
}
