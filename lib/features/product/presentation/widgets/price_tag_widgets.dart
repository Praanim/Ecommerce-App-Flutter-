import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

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
          fontSize: ValConstants.value16,
        ),
      ),
    );
  }
}
