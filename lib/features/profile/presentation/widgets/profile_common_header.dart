import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:flutter/material.dart';

class ProfileCommonHeader extends StatelessWidget {
  final String text;

  final IconData icon;

  const ProfileCommonHeader({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalGap.s,
        Row(
          children: [
            Icon(
              icon,
              size: IconConstants.iconSecondarySize,
              color: context.appColorScheme.secondary,
            ),
            HorizontalGap.s,
            Text(
              text,
              style: context.appTextTheme.headlineSmall,
            ),
          ],
        ),
      ],
    );
  }
}
