import 'dart:ui';
import 'package:e_book_admin/cubits/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'components/custom_button.dart';
import 'components/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit _loginCubit;
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;
  double screenWidthValue = 0;
  late bool statusLogin = true;
  var screenHeight =
      PlatformDispatcher.instance.views.first.physicalSize.height /
          PlatformDispatcher.instance.views.first.devicePixelRatio;

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidthValue = MediaQuery.of(context).size.width;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushNamed(context, '/admin_panel');
        }
        if (state.status == LoginStatus.submitting) {}
        if (state.status == LoginStatus.error) {
          setState(() {
            statusLogin = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
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
                                  controller: emailController,
                                  onChanged: (value) {
                                    _loginCubit.emailChanged(value);
                                  },
                                  validator: (input) {
                                    if (input.toString().isEmpty) {
                                      return 'Enter email';
                                    }
                                  },
                                  // validator: validateEmail,
                                ),
                                CustomTextField(
                                  label: 'Password',
                                  controller: passwordController,
                                  onChanged: (value) {
                                    _loginCubit.passwordChanged(value);
                                  },
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
                                statusLogin == false
                                    ? const Text(
                                        'Invalid account or password!',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16),
                                      )
                                    : const Text(''),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<LoginCubit, LoginState>(
                                      buildWhen: (previous, current) =>
                                          previous.status != current.status,
                                      builder: (context, state) {
                                        return Expanded(
                                          child: CustomButton(
                                            buttonText: "Login",
                                            buttonTextColor: Colors.white,
                                            onTap: () {
                                              setState(() {
                                                statusLogin = true;
                                              });
                                              if (loginFormKey.currentState!
                                                  .validate()) {
                                                _loginCubit.logIn();
                                              }
                                            },
                                          ),
                                        );
                                      },
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
      ),
    );
  }
}
