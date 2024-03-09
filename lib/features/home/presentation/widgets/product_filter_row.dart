import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductFilterRow extends StatelessWidget {
  final String title;

  const ProductFilterRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.appColorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.pad4, vertical: AppConstants.pad4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.appTextTheme.headlineSmall!
                .copyWith(color: primaryColor, fontWeight: FontWeight.w600),
          ),
          InkWell(
              onTap: () {
                context.goNamed(RouteConstants.productScreen);
              },
              child: Text(
                'View All',
                style: context.appTextTheme.titleMedium!.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ))
        ],
      ),
    );
  }
}
