import 'package:eccomerce_frontend/core/shared/custom_app_bar.dart';
import 'package:eccomerce_frontend/features/profile/data/models/profile_list_tile_item.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_circle_avatar.dart';
import 'package:eccomerce_frontend/features/profile/presentation/widgets/profile_list_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<ProfileListTileItem> profileItemsList = [
    ProfileListTileItem(
        title: 'Account Details',
        leadingIcon: const Icon(Icons.person_2),
        onTap: () {}),
    ProfileListTileItem(
        title: 'Delivery Address',
        leadingIcon: const Icon(Icons.home),
        onTap: () {}),
    ProfileListTileItem(
      title: 'Help',
      leadingIcon: const Icon(Icons.chat_sharp),
      onTap: () {},
    ),
    ProfileListTileItem(
      title: 'Notification Settings',
      leadingIcon: const Icon(Icons.notifications_active),
      onTap: () {},
    ),
    ProfileListTileItem(
      title: 'App Update',
      leadingIcon: const Icon(Icons.download),
      onTap: () {},
    ),
    ProfileListTileItem(
      title: 'Logout',
      leadingIcon: const Icon(Icons.signpost),
      onTap: () async {
        await FirebaseAuth.instance.signOut();
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
              itemCount: profileItemsList.length,
              itemBuilder: (context, index) {
                final profileItem = profileItemsList[index];
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
