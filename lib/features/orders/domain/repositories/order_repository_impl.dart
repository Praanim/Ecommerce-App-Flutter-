import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/orders/data/datasource/orders_data_source.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';
import 'package:eccomerce_frontend/features/orders/data/repositories/order_repository.dart';

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
