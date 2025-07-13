import 'package:app/app/data/cores/path_assets/path_image.dart';
import 'package:app/app/data/cores/widgets/button_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_email_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_password_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_widget.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/data/cores/path_assets/path_color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  logoApp,
                width: width * 0.5,
              ),
              SizedBox(height: height * 0.1,),
              SizedBox(
                width: width * 0.8,
                child: TextFieldEmailWidget(
                  controller: emailController,
                )
              ),
              SizedBox(
                width: width * 0.8,
                child: TextFieldPasswordWidget(
                  hintText: "Password",
                  controller: passwordController,
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: width * 0.8,
                child: Obx(() => CustomButtonWidget(
                  text: 'Login',
                  icon: Icons.login,
                  backgroundColor: OneHubColor.orane,
                  textColor: OneHubColor.black,
                  loading: controller.isLoading.value,
                  onPressed: () => controller.handleLogin(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                )),
              ),
              SizedBox(
                width: width * 0.8,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){
                        Get.toNamed(Routes.FORGOT_PASSWORD);
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: OneHubColor.orane
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: TextButton(
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: TextStyle(
                            color: OneHubColor.black
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: OneHubColor.orane
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

