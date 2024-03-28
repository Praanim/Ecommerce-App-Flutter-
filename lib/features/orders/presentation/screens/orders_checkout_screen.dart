import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/constants/text_constants.dart';
import 'package:nattt_bazaar/core/routes/route_constants.dart';
import 'package:nattt_bazaar/core/shared/custom_app_bar.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/date_formatter.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/core/widgets/custom_elevated_button.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';
import 'package:nattt_bazaar/features/orders/data/models/order_model.dart';
import 'package:nattt_bazaar/features/orders/presentation/providers/order_notifier.dart';
import 'package:nattt_bazaar/features/orders/presentation/providers/order_state.dart';
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
        child: SingleChildScrollView(
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
                    subtitle: userDetails.address != null
                        ? Text(
                            "${userDetails.address!.address} ${userDetails.address!.city}")
                        : Text(
                            'Add Address',
                            style: context.appTextTheme.bodySmall,
                          ),
                    onTap: () {
                      //navigate to address page if no address is found
                      context.pushNamed(RouteConstants.addressDetailsScreen);
                    });
              }),
              VerticalGap.l,
              const ProfileCommonHeader(
                  text: "Payment Providers", icon: Icons.payment),
              VerticalGap.m,
              Stack(
                children: [
                  Card(
                    child: Container(
                      width: 80,
                      height: 100,
                      decoration: const BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                              image: AssetImage(
                                ImageConstants.esewaLogoImage,
                              ),
                              fit: BoxFit.scaleDown)),
                    ),
                  ),
                  Positioned(
                    right: 3,
                    top: 2,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: context.appColorScheme.primary,
                      child: const Center(
                          child: Icon(
                        Icons.check,
                        size: IconConstants.iconPrimarySize,
                      )),
                    ),
                  ),
                ],
              ),
              VerticalGap.l,
              Consumer(builder: (context, ref, child) {
                //order notifier state listener
                _orderStateListener(ref, context);

                return SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: () {
                      //start esewa payment
                      try {
                        final totalAmount =
                            (quantity * product.price.toDouble());

                        EsewaFlutterSdk.initPayment(
                          esewaConfig: EsewaConfig(
                            environment: Environment.test,
                            clientId: dotenv.env['CLIENT_ID']!,
                            secretId: dotenv.env['SECRET_KEY']!,
                          ),
                          esewaPayment: EsewaPayment(
                              productId: product.id,
                              productName: product.title,
                              productPrice: totalAmount.toString(),
                              callbackUrl: ''),
                          onPaymentSuccess: (EsewaPaymentSuccessResult data) {
                            debugPrint(":::SUCCESS::: => $data");

                            final currentUserDetails =
                                ref.read(userDataProvider);

                            //order model
                            final OrderModel orderModel = OrderModel(
                              userId: currentUserDetails!.id!,
                              product: product,
                              status: "created",
                              quantity: quantity,
                              totalAmount: totalAmount,
                              transactionId: data.refId,
                              addressModel: currentUserDetails.address!,
                            );

                            //calling create orders
                            ref
                                .read(orderStateNotifierProvider.notifier)
                                .createOrder(orderModel);
                          },
                          onPaymentFailure: (data) {
                            debugPrint(":::FAILURE::: => $data");
                            _handleFailedOrCanceledOrder(context);
                          },
                          onPaymentCancellation: (data) {
                            debugPrint(":::CANCELLATION::: => $data");
                            _handleFailedOrCanceledOrder(context);
                          },
                        );
                      } on Exception catch (e) {
                        debugPrint("EXCEPTION : ${e.toString()}");
                      }
                    },
                    title: "Pay Now",
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void _orderStateListener(WidgetRef ref, BuildContext context) {
    ref.listen(
      orderStateNotifierProvider,
      (previous, next) {
        if (next is OrderCreated) {
          context.showSnackBar(
              message: "Product Successfully Created.",
              toastType: ToastType.success);
          _navigateToOrders(context);
        } else if (next is OrderFailure) {
          context.showSnackBar(
              message: "We have recieved your payment.Order Creation Ongoing.",
              toastType: ToastType.message);
          //TODO:notify admin using email or anything
          _navigateToOrders(context);
        }
      },
    );
  }

  void _navigateToOrders(BuildContext context) {
    context.pop();
    context.goNamed(RouteConstants.orderScreen);
  }

  void _handleFailedOrCanceledOrder(BuildContext context) {
    context.showSnackBar(
        message: TextConstants.failedOrderMssg, toastType: ToastType.error);
  }
}
