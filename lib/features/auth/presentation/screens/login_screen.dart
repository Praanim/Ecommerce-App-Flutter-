import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/routes/route_constants.dart';
import 'package:nattt_bazaar/core/shared/validations.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/auth_button.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/logo_image_widget.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/password_widget.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/text_form_field.dart';
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
                const LogoImageWidget(
                  assetUrl: ImageConstants.appLogo,
                ),
                VerticalGap.l,
                const AuthHeader(
                  text: 'Welcome Back!',
                ),
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
                PasswordWidget(passwordController: _passwordController),
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
                    child: const Text(
                      'Don\'t have an account? Sign Up',
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
}
