import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_email.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_password.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GAuthController authController = GAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Center the login form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Welcome!",
                    style: ResponsiveTextStyles.authTitle(context),
                  ),
                  Text(
                    "Login to Mood again!",
                    style: ResponsiveTextStyles.authDescription(context),
                  ),
                  SizedBox(height: 30),
                  TextBoxEmail(controller: emailController),
                  SizedBox(height: 20),
                  TextBoxPassword(controller: passwordController),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.sendEmail);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: ResponsiveTextStyles.authNormalText(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(() => CustomButton(
                    text: authController.isLoading.value ? "Logging in..." : "Login",
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                      final email = emailController.text.trim();
                      final password = passwordController.text;

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          'Validation Error',
                          'Email and password must not be empty',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        authController.isLoading.value = true;
                        authController.login(email, password);
                      }
                    },
                  )),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                        style: ResponsiveTextStyles.authNormalText(context),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.register);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Register now!",
                            style: ResponsiveTextStyles.authNormalText(context),
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
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Image.asset(
          flavour,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
