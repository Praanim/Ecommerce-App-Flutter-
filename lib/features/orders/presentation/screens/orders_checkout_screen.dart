import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/custom_app_bar.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/date_formatter.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';
import 'package:nattt_bazaar/features/orders/presentation/widgets/order_item_widgets.dart';
import 'package:nattt_bazaar/features/profile/presentation/widgets/profile_common_header.dart';
import 'package:nattt_bazaar/features/profile/presentation/widgets/profile_list_tile_widget.dart';

class OrdersCheckoutScreen extends StatelessWidget {
  final Product product;

  final int quantity;

  const OrdersCheckoutScreen(
      {super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Order Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.pad16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileCommonHeader(
                text: "Checkout Details", icon: Icons.info),
            VerticalGap.l,
            OrderItemWidget(
                product: product,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quantity: $quantity"),
                    VerticalGap.xs,
                    Text(
                        "Delivery Date: ${formatDate(DateTime.now().add(const Duration(days: 2)))}")
                  ],
                )),
            VerticalGap.l,
            const ProfileCommonHeader(
                text: "Shipping Details", icon: Icons.delivery_dining),
            VerticalGap.s,
            Consumer(builder: (context, ref, child) {
              final userDetails = ref.watch(userDataProvider)!;
              return ProfileListTileWidget(
                  text: "Delivery Address",
                  leadingIcon: const Icon(IconConstants.homeIcon),
                  subtitle: userDetails.address == null
                      ? Text(
                          "${userDetails.address!.address} ${userDetails.address!.city}")
                      : Text(
                          'Add Address',
                          style: context.appTextTheme.titleSmall,
                        ),
                  onTap: () {
                    //navigate to address page if no address is found
                  });
            })
          ],
        ),
      ),
    );
  }
}
