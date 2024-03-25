import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/remote.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';

abstract class OrdersDataSource {
  ///Function to create order for a user using userId
  Future<Either<AppException, OrderModel>> createOrder(OrderModel orderModel);

  ///Function to get order for a user using userId
  Future<Either<AppException, List<OrderModel>>> getUserOrders(String userId);
}

class OrderRemoteDataSource extends OrdersDataSource {
  final NetworkService dioNetworkService;

  OrderRemoteDataSource({required this.dioNetworkService});

  @override
  Future<Either<AppException, OrderModel>> createOrder(
      OrderModel orderModel) async {
    try {
      final eitherResponse =
          await dioNetworkService.post('/order', data: orderModel.toJson());

      return eitherResponse.fold((appException) => Left(appException),
          (appResponse) {
        final data = appResponse.data["data"];
        return Right(OrderModel.fromJson(data));
      });
    } catch (e) {
      return Left(SharedClass.unknownErrorInstance(
          identifier: "OrderRemoteDataSource.createOrder"));
    }
  }

  @override
  Future<Either<AppException, List<OrderModel>>> getUserOrders(
      String userId) async {
    try {
      final eitherResponse = await dioNetworkService.get(
        '/order/$userId',
      );

      return eitherResponse.fold((appException) => Left(appException),
          (appResponse) {
        final data = appResponse.data["data"] as List;
        return Right(
            data.map((product) => OrderModel.fromJson(product)).toList());
      });
    } catch (e) {
      return Left(SharedClass.unknownErrorInstance(
          identifier: "OrderRemoteDataSource.getUserOrder"));
    }
  }
}
