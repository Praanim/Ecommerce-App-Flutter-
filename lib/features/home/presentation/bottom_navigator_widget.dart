import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigatorWidget extends ConsumerWidget {
  //Bottom navigation screen to be displayed.
  final Widget child;
  const BottomNavigatorWidget({super.key, required this.child});

  //Bottom navigation bar items.
  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(
      icon: Icon(IconConstants.homeIcon,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconConstants.favouriteIcon),
      label: 'Favourite',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconConstants.cartIcon),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconConstants.profileIcon),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(currentPageNotifierProvider),
        onTap: (value) {
          ref.read(currentPageNotifierProvider.notifier).setIndex(value);
          _navigateToScreen(value, context);
        },
        items: _items,
      ),
    );
  }

  void _navigateToScreen(int value, BuildContext context) {
    switch (value) {
      case 0:
        return context.goNamed(RouteConstants.homeScreen);
      case 1:
        return context.goNamed(RouteConstants.favouriteScreen);
      case 2:
        return context.goNamed(RouteConstants.cartScreen);
      case 3:
        return context.goNamed(RouteConstants.profileScreen);

    }
  }
}
