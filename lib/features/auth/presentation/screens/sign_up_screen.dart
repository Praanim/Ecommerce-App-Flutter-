import 'package:nattt_bazaar/core/constants/constants.dart';
import 'package:nattt_bazaar/core/routes/route_constants.dart';
import 'package:nattt_bazaar/core/shared/validations.dart';
import 'package:nattt_bazaar/core/utils/context_extension.dart';
import 'package:nattt_bazaar/core/utils/gap.dart';
import 'package:nattt_bazaar/features/auth/data/models/user.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_providers.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/auth_button.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/logo_image_widget.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/password_widget.dart';
import 'package:nattt_bazaar/features/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ///text editing controllers for the different fields in the [SignUpScreen]
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    ///Initialization of textediting controllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColorScheme.onTertiaryContainer,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.pad16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoImageWidget(
                  assetUrl: ImageConstants.appLogo,
                ),
                VerticalGap.l,
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: AuthHeader(text: "Let's get started!")),
                VerticalGap.l,
                CustomTextFormField(
                  textEditingController: _nameController,
                  labelText: 'Full Name',
                  validator: (value) {
                    return Validations.isValidName(value!);
                  },
                ),
                VerticalGap.l,
                CustomTextFormField(
                  textEditingController: _emailController,
                  labelText: 'Email',
                  validator: (value) {
                    return Validations.validateEmail(value!);
                  },
                ),
                VerticalGap.l,
                PasswordWidget(passwordController: _passwordController),
                VerticalGap.xxxl,
                Consumer(builder: (context, ref, _) {
                  return AuthButton(
                    text: 'Sign Up',
                    onPressed: () async {
                      //proceed with signUp
                      ref.read(authNotifierProvider.notifier).signUpUser(
                            userModel: UserModel(
                                fullName: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim()),
                          );
                    },
                  );
                }),
                VerticalGap.l,
                TextButton(
                  onPressed: () {
                    // Navigate to sign-in page
                    context.goNamed(RouteConstants.loginScreen);
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
