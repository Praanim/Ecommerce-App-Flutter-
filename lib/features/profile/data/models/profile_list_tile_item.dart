import 'package:flutter/material.dart';

class ProfileListTileItem {
  final String title;

  final Icon leadingIcon;

  final void Function() onTap;

  ProfileListTileItem(
      {required this.title, required this.leadingIcon, required this.onTap});
}
