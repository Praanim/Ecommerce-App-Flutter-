import 'package:nattt_bazaar/core/services/notifications/local_notification_services.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';
import 'package:nattt_bazaar/features/orders/data/repositories/order_repository.dart';
import 'package:nattt_bazaar/features/orders/domain/providers/order_providers.dart';
import 'package:nattt_bazaar/features/orders/presentation/providers/order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderStateNotifierProvider =
    StateNotifierProvider.autoDispose<OrderNotifier, OrderState>((ref) =>
        OrderNotifier(ref.watch(orderRepoProvider))
          ..getOrdersForUser(ref.watch(userDataProvider)!.id!));

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository orderRepository;

  OrderNotifier(this.orderRepository) : super(OrderInitial());

  List<OrderModel> _cachedOrders = [];

  void createOrder(OrderModel orderModel) async {
    state = OrderLoading();
    final eitherResponse = await orderRepository.createOrder(orderModel);

    eitherResponse.fold((appException) {
      state = OrderFailure(appException: appException);
    }, (orderModel) async {
      //send notification to the user.
      // await LocalNotificationServices.showNotifications(
      //     title: "Order Created.",
      //     body:
      //         "We have successfully created your requested order to the specified location.Thank you!");

      //update state.
      _cachedOrders.insert(0, orderModel);
      state = OrderCreated();
      state = OrderSuccess(orders: _cachedOrders);
    });
  }

  //order create huna sath live orders ma add huna paryo. or .autodispose lagayeni vo.
  void getOrdersForUser(String userId) async {
    state = OrderLoading();
    final eitherResponse = await orderRepository.getUserOrder(userId);

    eitherResponse.fold((appException) {
      state = OrderFailure(appException: appException);
    }, (orders) async {
      //update state.
      _cachedOrders = orders;
      state = OrderSuccess(orders: _cachedOrders);
    });
  }
}
