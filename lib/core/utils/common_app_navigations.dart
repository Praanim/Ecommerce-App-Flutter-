import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

import '../routes/route_constants.dart';

void navigateToCheckoutPage(
    BuildContext context, Product product, int quantity) {
  context.pushNamed(RouteConstants.orderCheckoutScreen,
      extra: {'product': product, 'quantity': quantity});
}
