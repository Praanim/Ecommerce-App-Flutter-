import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:eccomerce_frontend/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/cart_notifier.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';
import 'package:eccomerce_frontend/features/home/presentation/bottom_navigator_widget.dart';
import 'package:eccomerce_frontend/features/cart/presentation/screens/cart_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_notifier.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/favourite_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/home_screen.dart';
import 'package:eccomerce_frontend/features/product/presentation/screens/product_details_screen.dart';
import 'package:eccomerce_frontend/features/product/presentation/screens/product_screen.dart';
import 'package:eccomerce_frontend/features/home/presentation/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey();
final GlobalKey<NavigatorState> shellNavigator = GlobalKey();

final GoRouter router = GoRouter(
    initialLocation: '/login',
    navigatorKey: rootNavigator,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: RouteConstants.loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
        redirect: (context, state) async {
          // print(testValue);

          //TODO: important fetch activities yeta halni ani tespaxi native screen pop
          //TODO: make this code more clean
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            //provider container.
            final container = ProviderScope.containerOf(context);

            //get user info from db
            final result = await container
                .read(getUserByEmailFutureProvider(currentUser.email!).future);
            if (result == null) {
              //null means some error has occure so navigate the user to login screen.
              return '/login';
            }

            //get cart for the respective user.
            await container
                .read(cartNotifierProvider.notifier)
                .getCartForTheUser(currentUser.uid);
            return '/home';
          }
          return '/login';
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
                routes: [
                  GoRoute(
                      path: 'product',
                      name: RouteConstants.productScreen,
                      builder: (context, state) => const ProductScreen(),
                      routes: [
                        GoRoute(
                          path: 'product-details',
                          name: RouteConstants.productDetailsScreen,
                          builder: (context, state) {
                            final map = state.extra as Map<String, dynamic>;
                            final Product product = map['product'];

                            return ProductDetailsScreen(
                              product: product,
                            );
                          },
                        )
                      ])
                ]),
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
