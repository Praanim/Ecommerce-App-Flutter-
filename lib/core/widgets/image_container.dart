import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final ImageProvider<Object> image;

  const ImageContainer({
    super.key,
    required this.image,
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
        image: DecorationImage(fit: BoxFit.cover, image: image),
      ),
    );
  }
}
