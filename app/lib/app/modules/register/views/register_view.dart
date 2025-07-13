import 'package:app/app/data/cores/path_assets/path_color.dart';
import 'package:app/app/data/cores/path_assets/path_icon.dart';
import 'package:app/app/data/cores/path_assets/path_image.dart';
import 'package:app/app/data/cores/services/auth_service.dart';
import 'package:app/app/data/cores/widgets/button_widget.dart';
import 'package:app/app/data/cores/widgets/outline_button_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_email_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_password_widget.dart';
import 'package:app/app/data/cores/widgets/text_field_widget.dart';
import 'package:app/app/modules/register/controllers/register_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Controllers for user input
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = AuthService();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
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
                SizedBox(height: height * 0.1),
                SizedBox(
                  width: width * 0.8,
                  child: TextFieldWidget(
                    hintText: "First Name",
                    icon: Icons.person,
                    controller: firstNameController,
                  ),
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextFieldWidget(
                    hintText: "Last Name",
                    icon: Icons.person,
                    controller: lastNameController,
                  ),
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextFieldEmailWidget(
                    controller: emailController,
                  ),
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextFieldPasswordWidget(
                    hintText: "Password",
                    controller: passwordController,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: width * 0.8,
                  child: Obx(() => CustomButtonWidget(
                    text: 'Register',
                    icon: Icons.login,
                    backgroundColor: OneHubColor.orane,
                    textColor: OneHubColor.black,
                    loading: controller.isLoading.value,
                    onPressed: () => controller.handleRegister(
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  )),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: width * 0.8,
                  child: OutlineButtonWidget(
                    text: 'Continue with Google',
                    imagePath: iconGoogle,
                    isNetwork: false,
                    onPressed: () async {
                      await authService.signInWithGoogle();
                    },
                    borderColor: OneHubColor.blackGrey,
                    textColor: OneHubColor.black,
                    imageSize: 20,
                  ),
                ),
                SizedBox(
                  width: width * 0.8,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: OneHubColor.black),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Login",
                          style: TextStyle(color: OneHubColor.orane),
                        ),
                      ],
                    ),
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
