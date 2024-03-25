import 'package:flutter/material.dart';
import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/shared/shared.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

class OrderItemWidget extends StatelessWidget {
  final Product product;

  final Widget subtitle;

  const OrderItemWidget(
      {super.key, required this.product, required this.subtitle});

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
                  SharedClass.checkAvailableProductImage(product),
                  fit: BoxFit.cover,
                )),
            HorizontalGap.xl,
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: context.appTextTheme.headlineSmall,
                  ),
                  VerticalGap.s,
                  subtitle,
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
