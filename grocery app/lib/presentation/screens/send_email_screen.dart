import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_email.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class SendEmailScreen extends StatefulWidget {
  const SendEmailScreen({super.key});

  @override
  State<SendEmailScreen> createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {

  final GAuthController authController = GAuthController();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        backgroundColor: GColor.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            arrowLeft,
            width: 24,
            height: 24,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.login);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                lock,
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              "Send Email",
              style: ResponsiveTextStyles.authTitle(context),
            ),
            Text(
              "Code verify send to your email",
              style: ResponsiveTextStyles.authDescription(context),
            ),
            SizedBox(height: 30),
            TextBoxEmail(controller: emailController),
            SizedBox(height: 30),
            Obx(() => CustomButton(
                text: authController.isLoading.value ? "Sending..." : "Send",
                onPressed: authController.isLoading.value
                ? null
                    : () {
                  final email = emailController.text.trim();
                  if (email.isEmpty) {
                    Get.snackbar("Error", "Please enter your email.");
                  } else if (!email.isEmail) {
                    Get.snackbar("Invalid Email", "Please enter a valid email.");
                  } else {
                    // Send password reset code if email is valid
                    authController.sendCodeToEmail(email);
                  }
                }
            )),
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
