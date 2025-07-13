import 'package:app/app/data/cores/path_assets/path_color.dart';
import 'package:app/app/data/cores/path_assets/path_image.dart';
import 'package:app/app/data/cores/widgets/button_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: OneHubColor.linear,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                logoApp,
                width: width * 0.5,
              ),
              SizedBox(height: height * 0.1),
              SizedBox(
                width: width * 0.8,
                child: TextFieldPasswordWidget(
                  controller: passwordController,
                  hintText: 'New Password',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: width * 0.8,
                child: TextFieldPasswordWidget(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width * 0.8,
                child: Obx(() => CustomButtonWidget(
                  text: 'Reset Password',
                  icon: Icons.lock_open,
                  backgroundColor: OneHubColor.orane,
                  textColor: OneHubColor.black,
                  // loading: controller.isLoading.value,
                  onPressed: () {

                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
