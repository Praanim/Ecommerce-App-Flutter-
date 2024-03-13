import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
import 'package:eccomerce_frontend/features/cart/presentation/providers/notifiers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_elevated_button.dart';

class AuthButton extends ConsumerWidget {
  //The name of the button
  final String text;

  ///on pressed function
  final void Function() onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      if (next is AuthSuccess) {
        //gets cart for the respective user
        ref
            .read(cartNotifierProvider.notifier)
            .getCartForTheUser(next.userModel.id!);

        //navigate to homeScreen
        context.goNamed(RouteConstants.homeScreen);
      } else if (next is AuthFailure) {
        context.showSnackBar(
            message: next.appException.message, toastType: ToastType.error);
      }
    });

    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        title: text,
        onPressed: onPressed,
        btnStyle: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: ValConstants.value8),
            backgroundColor: context.appColorScheme.primary),
      ),
    );
  }
}
