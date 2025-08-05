import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_password.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final GAuthController authController = GAuthController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                "Reset password",
                style: ResponsiveTextStyles.authTitle(context),
              ),
              Text(
                "Change your password",
                style: ResponsiveTextStyles.authDescription(context),
              ),
              SizedBox(height: 30),
              TextBoxPassword(controller: passwordController),
              SizedBox(height: 20),
              TextBoxPassword(controller: confirmPasswordController, label: "Confirm password",),
              SizedBox(height: 50),
              Obx(() => CustomButton(
                  text: authController.isLoading.value ? "Changing..." : "Change",
                  onPressed: authController.isLoading.value
                  ? null
                      : () {
                    final newPassword = passwordController.text.trim();
                    final confirmNewPassword = confirmPasswordController.text.trim();
                    if(newPassword.isEmpty){
                      Get.snackbar("Error", "Please enter new password.");
                    }else if(confirmNewPassword.isEmpty){
                      Get.snackbar("Error", "Please enter new password.");
                    }else if(confirmNewPassword != newPassword){
                      Get.snackbar("Error", "Confirm password doesn't match!.");
                    }else{
                      authController.resetPassword(newPassword, confirmNewPassword);
                    }
                  }
              )),
            ],
          ),
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
