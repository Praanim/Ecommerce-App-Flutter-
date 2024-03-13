import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String text;
  const AuthHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.appTextTheme.headlineSmall);
  }
}
