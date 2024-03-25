import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccomerce_frontend/core/constants/button_style_constants.dart';
import 'package:eccomerce_frontend/core/constants/text_constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/core/widgets/image_container.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/notifiers/cart_notifier.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/orders/data/models/order_model.dart';
import 'package:eccomerce_frontend/features/orders/presentation/providers/order_notifier.dart';
import 'package:eccomerce_frontend/features/orders/presentation/providers/order_state.dart';
import 'package:eccomerce_frontend/features/product/presentation/widgets/product_description_container.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatelessWidget {
  ///Individual Product Model
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(
            image: CachedNetworkImageProvider(
                SharedClass.checkAvailableProductImage(product)),
          ),
          VerticalGap.s,
          ProductDescriptionContainer(product: product),
          VerticalGap.l,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer(builder: (context, ref, child) {
                return CustomElevatedButton(
                  title: 'Add to cart',
                  onPressed: () async {
                    //TODO:make quantity dynamicx
                    await ref
                        .read(cartNotifierProvider.notifier)
                        .addProductToCart(
                            ref.read(userDataProvider)!.id!, product, 1)
                        .then((_) {
                      context.showSnackBar(
                          message: 'Product Successfully Added to Cart',
                          toastType: ToastType.success);
                      context.pop();
                    });
                  },
                  titleStyle: context.appTextTheme.displaySmall!
                      .copyWith(color: context.appColorScheme.primary),
                  btnStyle: CustomBtnStyle.secondaryBtnStyle(context),
                );
              }),
              Consumer(builder: (context, ref, child) {
                //order notifier state listener
                _orderStateListener(ref, context);

                return CustomElevatedButton(
                  title: 'Buy Now',
                  onPressed: () {
                    try {
                      final CLIENT_ID =
                          'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
                      final SECRET_KEY =
                          'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';
                      EsewaFlutterSdk.initPayment(
                        esewaConfig: EsewaConfig(
                          environment: Environment.test,
                          clientId: CLIENT_ID,
                          secretId: SECRET_KEY,
                        ),
                        esewaPayment: EsewaPayment(
                            productId: product.id,
                            productName: product.title,
                            productPrice: product.price.toString(),
                            callbackUrl: ''),
                        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
                          debugPrint(":::SUCCESS::: => $data");

                          final currentUserDetails = ref.read(userDataProvider);

                          //order model
                          final OrderModel orderModel = OrderModel(
                            userId: currentUserDetails!.id!,
                            product: product,
                            status: data.status,
                            quantity: 1,
                            totalAmount: product.price.toDouble(),
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
                );
              }),
            ],
          ),
          VerticalGap.s,
        ],
      ),
    ));
  }

  void _orderStateListener(WidgetRef ref, BuildContext context) {
    ref.listen(
      orderStateNotifierProvider,
      (previous, next) {
        if (next is OrderSuccess) {
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
