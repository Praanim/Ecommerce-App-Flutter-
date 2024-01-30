import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.2,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(ImageConstants.randomNetworkImageUrl),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppConstants.pad4),
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
    );
  }
}
