import 'package:eccomerce_frontend/core/shared/validations.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isPasswordVisibe = ref.watch(passwordVisibilityProvider);
      return CustomTextFormField(
        trailing: IconButton(
            onPressed: () {
              ref.read(passwordVisibilityProvider.notifier).state =
                  !isPasswordVisibe;
            },
            icon: isPasswordVisibe
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility)),
        obscureText: isPasswordVisibe ? false : true,
        textEditingController: _passwordController,
        labelText: "Password",
        textInputAction: TextInputAction.done,
        validator: (value) {
          return Validations.checkEmpty(value!);
        },
      );
    });
  }
}
