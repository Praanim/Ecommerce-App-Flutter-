import 'package:nattt_bazaar/core/routes/app_routes.dart';
import 'package:nattt_bazaar/core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: "Ecommerce App",
      theme: AppTheme.lightThemeData,
    );
  }
}
