import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;

  const ImageContainer({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight / 1.9,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(ValConstants.value24),
            bottomRight: Radius.circular(ValConstants.value24)),
        image: DecorationImage(
            fit: BoxFit.cover, image: CachedNetworkImageProvider(imageUrl)),
      ),
    );
  }
}
