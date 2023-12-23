import 'dart:ui';
import 'package:e_book_admin/cubits/cubit.dart';
import 'package:e_book_admin/screen/login/components/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/custom_button.dart';
import 'components/custom_textfield.dart';

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
        if (state.status == LoginStatus.error) {
          setState(() {
            statusLogin = false;
          });
        }
      },
      child: Scaffold(
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
                    Image.asset(
                      'assets/image/login_page_logo.png',
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 400,
                              width: 450,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTextField(
                                      hintText: "Email",
                                      controller: emailController,
                                      onChanged: (value) {
                                        _loginCubit.emailChanged(value);
                                      },
                                      // validator: validateEmail,
                                    ),
                                    PasswordInput(
                                      controller: passwordController,
                                      hint: 'Password',
                                      onChanged: (value) {
                                        _loginCubit.passwordChanged(value);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    statusLogin == false
                                        ? const Text(
                                            'Invalid account or password!', style: TextStyle(color: Colors.redAccent, fontSize: 16),)
                                        : const Text(''),
                                    BlocBuilder<LoginCubit, LoginState>(
                                      buildWhen: (previous, current) =>
                                          previous.status != current.status,
                                      builder: (context, state) {
                                        return state.status ==
                                                LoginStatus.submitting
                                            ? const CircularProgressIndicator()
                                            : CustomButton(
                                                buttonText: "Login",
                                                buttonTextColor: Colors.white,
                                                borderRadius:
                                                    screenHeight / 20.0667,
                                                onTap: () {
                                                  setState(() {
                                                    statusLogin = true;
                                                  });
                                                  if (loginFormKey.currentState!
                                                      .validate()) {
                                                    _loginCubit.logIn();
                                                  }
                                                },
                                              );
                                      },
                                    ),
                                  ],
                                ),
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
        ),
      ),
    );
  }
}
