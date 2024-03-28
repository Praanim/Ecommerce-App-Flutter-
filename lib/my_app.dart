import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nattt_bazaar/core/routes/app_routes.dart';
import 'package:nattt_bazaar/core/services/internet_connection/internet_connection_notifier.dart';
import 'package:nattt_bazaar/core/services/internet_connection/internet_connection_provider.dart';
import 'package:nattt_bazaar/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:nattt_bazaar/core/widgets/no_internet_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetState = ref.watch(internetConnectionProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: "Ecommerce App",
      theme: AppTheme.lightThemeData,
      builder: (context, child) {
        if (internetState == ConnectivityStatus.isDisonnected) {
          return const NoInternetScreen();
        }
        return child!;
      },
    );
  }
}
