import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';

abstract class OrderState {}

class OrderLoading extends OrderState {}

class OrderInitial extends OrderState {}

class OrderCreated extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> orders;

  OrderSuccess({required this.orders});
}

class OrderFailure extends OrderState {
  final AppException appException;

  OrderFailure({required this.appException});
}
