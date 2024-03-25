import 'package:eccomerce_frontend/core/services/notifications/local_notification_services.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';
import 'package:eccomerce_frontend/features/orders/data/repositories/order_repository.dart';
import 'package:eccomerce_frontend/features/orders/domain/providers/order_providers.dart';
import 'package:eccomerce_frontend/features/orders/presentation/providers/order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderStateNotifierProvider =
    StateNotifierProvider.autoDispose<OrderNotifier, OrderState>(
        (ref) => OrderNotifier(ref.watch(orderRepoProvider)));

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository orderRepository;

  OrderNotifier(this.orderRepository) : super(OrderInitial());

  void createOrder(OrderModel orderModel) async {
    state = OrderLoading();
    final eitherResponse = await orderRepository.createOrder(orderModel);

    eitherResponse.fold((appException) {
      state = OrderFailure(appException: appException);
    }, (orderModel) async {
      //send notification to the user.
      await LocalNotificationServices.showNotifications(
          title: "Order Created.",
          body:
              "We have successfully created your requested order to the specified location.Thank you!");

      //update user.
      state = OrderSuccess(orderModel: orderModel);
    });
  }

  //order create huna sath live orders ma add huna paryo. or .autodispose lagayeni vo.
}
