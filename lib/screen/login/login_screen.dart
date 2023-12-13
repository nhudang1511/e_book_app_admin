import 'dart:ui';
import 'package:flutter/material.dart';
import 'components/custom_button.dart';
import 'components/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double screenWidthValue = 0;
  var screenHeight = PlatformDispatcher.instance.views.first.physicalSize.height /
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    final screenWidthValue = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Web Admin",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/image/login_page_logo.png',
                    height: screenWidthValue * 0.42,
                    width: screenWidthValue * 0.42,
                  ),
                ],
              ),
              SizedBox(
                width: 380,
                child: Stack(
                  children: [
                    Positioned(
                      top: 110,
                      child: Image.asset(
                        'assets/image/gradient_circle.png',
                        height: 100,
                      ),
                    ),
                    Positioned(
                      top: 230,
                      left: 250,
                      child: Image.asset(
                        'assets/image/gradient_circle.png',
                        height: 100,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 185,
                      child: Image.asset(
                        'assets/image/gradient_circle.png',
                        height: 100,
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      left: 90,
                      child: Image.asset(
                        'assets/image/gradient_circle.png',
                        height: 75,
                      ),
                    ),
                    Column(
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
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomTextField(
                                        hintText: "Email",
                                        controller: emailController,
                                        // validator: validateEmail,
                                      ),
                                      CustomTextField(
                                        hintText: "Password",
                                        controller: passwordController,
                                        // validator: validateField,
                                      ),
                                      CustomButton(
                                        buttonText: "Login",
                                        buttonTextColor: const Color(0xFF141318),
                                        borderRadius: screenHeight / 20.0667,
                                        onTap: () {
                                          // loginAdmin();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
