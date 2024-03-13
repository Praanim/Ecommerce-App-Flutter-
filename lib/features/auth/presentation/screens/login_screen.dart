import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/shared/validations.dart';
import 'package:eccomerce_frontend/core/utils/context_extension.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/logo_image_widget.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  //login logic
  Future<void> _submitForm(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final authStateNotifier = ref.read(authNotifierProvider.notifier);
      await authStateNotifier.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColorScheme.onTertiaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LogoImageWidget(),
                VerticalGap.l,
                Text('Welcome Back!',
                    style: context.appTextTheme.headlineSmall),
                VerticalGap.l,
                CustomTextFormField(
                  textEditingController: _emailController,
                  labelText: "Email",
                  validator: (value) {
                    return Validations.validateEmail(value!);
                  },
                ),
                VerticalGap.l,
                // Icons.remove_red_eye_sharp
                Consumer(builder: (context, ref, child) {
                  final isPasswordVisibe =
                      ref.watch(passwordVisibilityProvider);
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
                }),
                VerticalGap.xxl,
                Consumer(builder: (context, ref, _) {
                  return Center(
                    child: AuthButton(
                      text: 'Login',
                      onPressed: () async {
                        //requests login
                        await _submitForm(ref);
                      },
                    ),
                  );
                }),
                VerticalGap.l,
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to sign-up page
                      context.goNamed(RouteConstants.signUpScreen);
                    },
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: context.appTextTheme.titleLarge!
                          .copyWith(color: context.appColorScheme.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
