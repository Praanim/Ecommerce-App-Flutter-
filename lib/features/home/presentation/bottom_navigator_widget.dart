import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/features/cart/presentation/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigatorWidget extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  //Bottom navigation screen to be displayed.
  BottomNavigatorWidget(
    this.navigationShell, {
    super.key,
  });

  //Bottom navigation bar items.
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconConstants.homeIcon,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconConstants.ordersIcon),
      label: 'Orders',
    ),
    BottomNavigationBarItem(
      icon: Consumer(builder: (context, ref, child) {
        final itemCount = ref.watch(cartItemsCountProvider);
        return itemCount == 0
            ? const Icon(IconConstants.cartIcon)
            : Badge(
                backgroundColor: context.appColorScheme.primary,
                label: Text(itemCount.toString()),
                child: const Icon(IconConstants.cartIcon));
      }),
      label: 'Cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconConstants.profileIcon),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          _onTap(context, value);
        },
        items: _items,
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  // void _navigateToScreen(int value, BuildContext context) {
  //   switch (value) {
  //     case 0:
  //       return context.goNamed(RouteConstants.homeScreen);
  //     case 1:
  //       return context.goNamed(RouteConstants.favouriteScreen);
  //     case 2:
  //       return context.goNamed(RouteConstants.cartScreen);
  //     case 3:
  //       return context.goNamed(RouteConstants.profileScreen);
  //   }
  // }
}
