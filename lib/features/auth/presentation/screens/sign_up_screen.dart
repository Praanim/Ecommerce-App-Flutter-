import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/core/utils/gap.dart';
import 'package:eccomerce_frontend/features/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {

 const  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  ///text editing controllers for the different fields in the [SignUpScreen]
  late final TextEditingController _nameController ;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();

    ///Initialization of textediting controllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding:const EdgeInsets.all(AppConstants.pad16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(textEditingController: _nameController, labelText: 'Full Name'),
            VerticalGap.l,
            CustomTextFormField(textEditingController: _emailController, labelText: 'Email'),
            VerticalGap.l,
            CustomTextFormField(textEditingController: _passwordController, labelText: 'Password'),
            VerticalGap.l,
            CustomTextFormField(textEditingController: _confirmPasswordController, labelText: 'Confirm Password'),
            VerticalGap.xxxl,
            ElevatedButton(
              onPressed: () {
                // // Handle sign-up logic
                // String fullName = ''; // Get the value from the full name field
                // String email = ''; // Get the value from the email field
                // String password = _passwordController.text;
                // String confirmPassword = _confirmPasswordController.text;

                // // Check if passwords match before proceeding
                // if (password == confirmPassword) {
                //   // Passwords match, continue with registration logic
                // } else {
                //   // Display an error message or handle mismatched passwords
                // }

                context.pop();
              },
              child:const  Text('Sign Up'),
            ),
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
    );
  }
}