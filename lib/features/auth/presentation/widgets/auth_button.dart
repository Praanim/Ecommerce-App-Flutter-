import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
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
        context.goNamed(RouteConstants.homeScreen); //navigate to homeScreen
      } else if (next is AuthFailure) {
        SharedClass.showMySnackBar(context, next.appException.message);
      }
    });

    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        title: 'Login',
        onPressed: onPressed,
        btnStyle: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: ValConstants.value8),
            backgroundColor: context.appColorScheme.primary),
        titleStyle: context.appTextTheme.bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
