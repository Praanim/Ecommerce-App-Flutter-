import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class LogoImageWidget extends StatelessWidget {
  final String assetUrl;

  const LogoImageWidget({
    super.key,
    required this.assetUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: context.screenHeight * 0.4,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(assetUrl))));
  }
}
