import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';

abstract class OrderState {}

class OrderLoading extends OrderState {}

class OrderInitial extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> orders;

  OrderSuccess({required this.orders});
}

class OrderFailure extends OrderState {
  final AppException appException;

  OrderFailure({required this.appException});
}
