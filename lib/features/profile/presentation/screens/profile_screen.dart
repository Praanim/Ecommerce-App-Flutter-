import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/features/profile/data/models/profile_list_tile_item.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/logout_bottom_sheet_widget.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_circle_avatar.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_list_tile_widget.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileListTileItem> profileItemsList(BuildContext context) => [
        ProfileListTileItem(
            title: 'Account Details',
            leadingIcon: const Icon(IconConstants.personIcon),
            onTap: () {
              context.goNamed(RouteConstants.accountDetailsScreen);
            }),
        ProfileListTileItem(
            title: 'Delivery Address',
            leadingIcon: const Icon(IconConstants.homeIcon),
            onTap: () {
              context.goNamed(RouteConstants.userAddressScreen);
            }),
        ProfileListTileItem(
          title: 'Help',
          leadingIcon: const Icon(IconConstants.helpIcon),
          onTap: () {},
        ),
        ProfileListTileItem(
          title: 'Notification Settings',
          leadingIcon: const Icon(IconConstants.notificationIcon),
          onTap: () {},
        ),
        ProfileListTileItem(
          title: 'App Update',
          leadingIcon: const Icon(IconConstants.downloadIcon),
          onTap: () {},
        ),
        ProfileListTileItem(
          title: 'Logout',
          leadingIcon: const Icon(IconConstants.logOutIcon),
          onTap: () async {
            context.showCustomModalBottomSheet(
                child: const LogOutBottomSheetWidget());
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          const Center(
            child: ProfileCircleAvatar(),
          ),
          Expanded(
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: profileItemsList(context).length,
              itemBuilder: (context, index) {
                final profileItem = profileItemsList(context)[index];
                return ProfileListTileWidget(
                  text: profileItem.title,
                  leadingIcon: profileItem.leadingIcon,
                  onTap: profileItem.onTap,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
