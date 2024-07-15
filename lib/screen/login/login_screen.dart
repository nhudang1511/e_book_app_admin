import 'package:e_book_admin/utils/utils.dart';
import 'package:e_book_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart' as providers;
import 'components/custom_button.dart';
import 'components/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;
  double screenWidthValue = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<providers.AuthProvider>(context);
    final screenWidthValue = MediaQuery.of(context).size.width;
    if (authProvider.status == providers.Status.Authenticating) {
      return const Loading();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  LottieBuilder.asset(
                    "assets/lottie/login.json",
                    height: screenWidthValue * 0.4,
                    width: screenWidthValue * 0.4,
                  ),
                ],
              ),
              SizedBox(
                width: 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Container(
                        height: 400,
                        width: 450,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              // Shadow color
                              spreadRadius: 5,
                              // Spread radius
                              blurRadius: 7,
                              // Blur radius
                              offset: const Offset(0, 3),
                            )
                          ],
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 32),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Login",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                CustomTextField(
                                  label: "Email",
                                  icon: Icons.email,
                                  controller: authProvider.email,
                                  validator: (input) {
                                    if (input.toString().isEmpty) {
                                      return 'Enter email';
                                    }
                                    return null;
                                  },
                                  // validator: validateEmail,
                                ),
                                CustomTextField(
                                  label: 'Password',
                                  icon: Icons.lock,
                                  controller: authProvider.password,
                                  isObscureText: _passwordVisible,
                                  suffixIcon: _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  onSuffixIcon: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  validator: (input) {
                                    if (input.toString().isEmpty) {
                                      return 'Enter password';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        buttonText: "Login",
                                        buttonTextColor: Colors.white,
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (!await authProvider.logIn()) {
                                              ShowSnackBar.error(
                                                  'Invalid email or password.',
                                                  context);
                                              return;
                                            } else {
                                              ShowSnackBar.success(
                                                  "Login successfully",
                                                  context);
                                              authProvider.clearController();
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
