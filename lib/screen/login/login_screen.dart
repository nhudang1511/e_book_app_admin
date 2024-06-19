import 'package:e_book_admin/config/routes/route_names.dart';
import 'package:e_book_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidthValue = MediaQuery.of(context).size.width;
    return authProvider.status == Status.Authenticating
        ? const Loading()
        : Scaffold(
            key: _key,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            body: SingleChildScrollView(
              child: Form(
                key: authProvider.formkey,
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                    CustomTextField(
                                      label: "Email",
                                      icon: Icons.email,
                                      controller: authProvider.email,
                                      onChanged: (value) {},
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
                                      onChanged: (value) {},
                                      isObscureText: _passwordVisible,
                                      suffixIcon: _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      onSuffixIcon: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            buttonText: "Login",
                                            buttonTextColor: Colors.white,
                                            onTap: () async{
                                              if (authProvider.formkey.currentState!
                                                  .validate()) {
                                                if(!await authProvider.logIn()) {
                                                  return ;
                                                }
                                                authProvider.clearController();

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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
