import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final CardTheme? cardTheme;

  const CustomCard({super.key, required this.child, this.cardTheme});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: cardTheme?.shape ?? context.cardTheme.shape,
      color: cardTheme?.color ?? context.cardTheme.color,
      child: child,
    );
  }
}
