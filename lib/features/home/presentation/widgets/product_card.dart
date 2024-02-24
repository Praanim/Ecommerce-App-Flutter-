import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  ///[Product] details model
  final Product product;

  ///on Product card tap event.
  final void Function()? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        //TODO:add directly to favourites
      },
      onTap: () {
        context.goNamed(RouteConstants.productDetailsScreen,
            extra: {'product': product});
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          // height: MediaQuery.of(context).size.height/ 3,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              ImageConstants.randomNetworkImageUrl),
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.pad4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.title),
                        Text('Rs.${product.price}')
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
