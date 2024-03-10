import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget(
      {required this.text,
      required this.leadingIcon,
      required this.onTap,
      super.key});

  final Widget leadingIcon;
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.pad8, vertical: AppConstants.pad6),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppConstants.primaryBorderRadius)),
        leading: leadingIcon,
        title: Text(
          text,
          style: context.appTextTheme.bodyMedium,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: IconConstants.iconPrimarySize,
        ),
        onTap: onTap,
      ),
    );
  }
}
