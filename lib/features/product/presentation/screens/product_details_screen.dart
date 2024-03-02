import 'package:eccomerce_frontend/core/constants/button_style_constants.dart';
import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/themes/app_colors.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/core/widgets/custom_card.dart';
import 'package:eccomerce_frontend/core/widgets/custom_elevated_button.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';

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
          const _ImageContainer(),
          VerticalGap.s,
          ProductDescriptionContainer(product: product),
          VerticalGap.s,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton(
                title: 'Add to cart',
                onPressed: () {},
                titleStyle: context.appTextTheme.displaySmall!
                    .copyWith(color: context.appColorScheme.primary),
                btnStyle: CustomBtnStyle.secondaryBtnStyle(context),
              ),
              CustomElevatedButton(
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
                          productId: "1d71jd81",
                          productName: "Product One",
                          productPrice: "20",
                          callbackUrl: ''),
                      onPaymentSuccess: (EsewaPaymentSuccessResult data) {
                        debugPrint(":::SUCCESS::: => $data");
                        // verifyTransactionStatus(data);
                      },
                      onPaymentFailure: (data) {
                        debugPrint(":::FAILURE::: => $data");
                      },
                      onPaymentCancellation: (data) {
                        debugPrint(":::CANCELLATION::: => $data");
                      },
                    );
                  } on Exception catch (e) {
                    debugPrint("EXCEPTION : ${e.toString()}");
                  }
                },
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class ProductDescriptionContainer extends StatelessWidget {
  final Product product;

  const ProductDescriptionContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(ValConstants.value8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.title,
                    style: context.appTextTheme.headlineMedium!
                        .copyWith(color: context.appColorScheme.primary)),
                PriceTag(price: product.price),
              ],
            ),
            VerticalGap.xs,
            //TODO:Can add show more thing
            Text(
              '${product.title} ${TextConstants.loremIpsum}',
              style: context.appTextTheme.displaySmall,
            )
          ],
        ),
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final int price;

  const PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ValConstants.value8),
      decoration: BoxDecoration(
          color: context.appColorScheme.primary,
          borderRadius:
              const BorderRadius.all(Radius.circular(ValConstants.value20))),
      child: Text(
        'Rs. $price',
        style: context.appTextTheme.displayMedium!.copyWith(
            fontSize: ValConstants.value16, color: DarkColor.secondaryColor),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight / 1.9,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(ValConstants.value24),
            bottomRight: Radius.circular(ValConstants.value24)),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(ImageConstants.randomNetworkImageUrl)),
      ),
    );
  }
}
