import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class NoContentWidget extends StatelessWidget {
  final String text;

  const NoContentWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: context.appTextTheme.headlineSmall),
    );
  }
}
