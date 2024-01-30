import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:eccomerce_frontend/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/bottom_navigator_widget.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/cart_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/favourite_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/home_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey();
final GlobalKey<NavigatorState> shellNavigator = GlobalKey();


final GoRouter router = GoRouter(
    initialLocation: '/home',
    navigatorKey: rootNavigator,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: RouteConstants.loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/signUp',
        name: RouteConstants.signUpScreen,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),

      //bottom navigation bar widget
      ShellRoute(
          navigatorKey: shellNavigator,
          builder: (context, state, child) => BottomNavigatorWidget(
                child: child,
              ),
          routes: [
            GoRoute(
              path: '/home',
              name: RouteConstants.homeScreen,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/favourite',
              name: RouteConstants.favouriteScreen,
              builder: (context, state) => const FavouriteScreen(),
            ),
            GoRoute(
              path: '/cart',
              name: RouteConstants.cartScreen,
              builder: (context, state) => const CartScreen(),
            ),
            GoRoute(
              path: '/profile',
              name: RouteConstants.profileScreen,
              builder: (context, state) => const ProfileScreen(),
            ),
          ])
    ]);