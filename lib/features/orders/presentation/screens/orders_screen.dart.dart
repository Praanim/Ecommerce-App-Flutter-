import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_loading_widget.dart';
import 'package:eccomerce_frontend/core/widgets/no_content_widget.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';
import 'package:eccomerce_frontend/features/orders/presentation/providers/order_notifier.dart';
import 'package:eccomerce_frontend/features/orders/presentation/providers/order_state.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_common_header.dart';
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
                              .map((orderModel) =>
                                  OrderItemWidget(orderModel: orderModel))
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

class OrderItemWidget extends StatelessWidget {
  final OrderModel orderModel;

  const OrderItemWidget({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.pad8),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.pad8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 3,
                child: Image.network(
                  SharedClass.checkAvailableProductImage(orderModel.product),
                  fit: BoxFit.cover,
                )
                // Container(
                //   height: 10,
                //   width: 50,
                //   decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.circular(AppConstants.primaryBorderRadius),
                //       image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: NetworkImage(
                //               SharedClass.checkAvailableProductImage(
                //                   orderModel.product)))),
                // ),
                ),
            HorizontalGap.xl,
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderModel.product.title,
                    style: context.appTextTheme.headlineSmall,
                  ),
                  VerticalGap.s,
                  Text(
                      "Address: ${orderModel.addressModel.address} ${orderModel.addressModel.city} ${orderModel.addressModel.address}"),
                  VerticalGap.s,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity: ${orderModel.quantity}"),
                      Text("Status: ${orderModel.status}")
                    ],
                  ),
                  VerticalGap.s,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
