import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/custom_app_bar.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/core/widgets/custom_loading_widget.dart';
import 'package:nattt_bazaar/core/widgets/no_content_widget.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';
import 'package:nattt_bazaar/features/orders/presentation/providers/order_notifier.dart';
import 'package:nattt_bazaar/features/orders/presentation/providers/order_state.dart';
import 'package:nattt_bazaar/features/orders/presentation/widgets/order_item_widgets.dart';
import 'package:nattt_bazaar/features/profile/presentation/widgets/profile_common_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text("Orders"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppConstants.pad16),
          child: Consumer(builder: (context, ref, child) {
            final orderState = ref.watch(orderStateNotifierProvider);

            if (orderState is OrderSuccess) {
              return orderState.orders.isEmpty
                  ? const NoContentWidget(text: "No orders found!!!")
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ProfileCommonHeader(
                              text: "All Orders",
                              icon: IconConstants.ordersIcon),
                          VerticalGap.xl,
                          ...orderState.orders
                              .map((orderModel) => OrderItemWidget(
                                    product: orderModel.product,
                                    subtitle: OrderLoadedWidget(
                                        orderModel: orderModel),
                                  ))
                              .toList()
                        ],
                      ),
                    );
            } else if (orderState is OrderLoading) {
              return const CustomLoadingWidget();
            }
            return const NoContentWidget(text: "Could not fetch orders");
          }),
        ));
  }
}

class OrderLoadedWidget extends StatelessWidget {
  const OrderLoadedWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Address: ${orderModel.addressModel.address} ${orderModel.addressModel.city}"),
        VerticalGap.s,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Quantity: ${orderModel.quantity}"),
            Text("Status: ${orderModel.status}")
          ],
        ),
      ],
    );
  }
}
