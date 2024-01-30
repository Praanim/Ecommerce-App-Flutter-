import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
                textEditingController: _emailController, labelText: "Email"),
            VerticalGap.l,
            CustomTextFormField(
                textEditingController: _passwordController,
                labelText: "Password"),
            VerticalGap.xxl,
            Consumer(builder: (context, ref, _) {
              final state = ref.watch(authStateNotifierProvider);

              ref.listen(authStateNotifierProvider, (previous, next) { 
                if(next is AuthSuccess){
                  context.go('/'); //navigate to homeScreen
                }
              });

              if (state is AuthLoading) {
                return _button(
                  child: const CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () async {
                  final authStateNotifier =
                      ref.read(authStateNotifierProvider.notifier);
                  await authStateNotifier.loginUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                child: const Text('Sign In'),
              );
            }),
            VerticalGap.l,
            TextButton(
              onPressed: () {
                // Navigate to sign-up page
                context.goNamed(RouteConstants.signUpScreen);
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _button({
    void Function()? onPressed,
    required Widget child,
  }) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
