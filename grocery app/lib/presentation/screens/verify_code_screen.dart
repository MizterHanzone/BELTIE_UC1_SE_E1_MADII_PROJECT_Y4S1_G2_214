import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  
  final GAuthController authController = GAuthController();

  final TextEditingController otpController = TextEditingController();

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
              "Verify",
              style: ResponsiveTextStyles.authTitle(context),
            ),
            Text(
              "Enter code from your email",
              style: ResponsiveTextStyles.authDescription(context),
            ),
            SizedBox(height: 30),
            OtpTextField(
              numberOfFields: 5,
              borderColor: Colors.grey,
              filled: true,
              fillColor: GColor.whiteGray,
              showFieldAsBox: true,
              showCursor: true,
              fieldWidth: 53,
              fieldHeight: 55,
              onCodeChanged: (String code) {
                otpController.text = code;
              },
              onSubmit: (String verificationCode) {
                otpController.text = verificationCode;
              },
            ),
            SizedBox(height: 30),
            Obx(() => CustomButton(
                text: authController.isLoading.value ? "Verifying..." : "Verify", 
                onPressed: authController.isLoading.value
                ? null
                    : () {
                  final otpCode = otpController.text.trim();
                  if (otpCode.isEmpty) {
                    Get.snackbar("Error", "Please enter your OTP.");
                  } else if (otpCode.length != 5) {
                    Get.snackbar("Invalid OTP code", "OTP code must be 5 character.");
                  } else {
                    // Send password reset code if email is valid
                    authController.verifyCode(otpCode);
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
