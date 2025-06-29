import 'package:app/app/data/cores/path_assets/path_image.dart';
import 'package:app/app/data/cores/widgets/button_widget.dart';
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

    final TextEditingController usernameController = TextEditingController();
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
                child: TextFieldWidget(
                  hintText: "Username",
                  icon: Icons.person,
                  controller: usernameController,
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: TextFieldPasswordWidget(
                  hintText: "Password",
                  controller: passwordController,
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){},
                      child: Text(
                          "Forgot password?",
                        style: TextStyle(
                            color: OneHubColor.blackGrey
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: CustomButtonWidget(
                  text: 'Login',
                  icon: Icons.login,
                  backgroundColor: OneHubColor.orane,
                  textColor: OneHubColor.white,
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      child: Text(
                          "Don't have account? Register",
                        style: TextStyle(
                          color: OneHubColor.blackGrey
                        ),
                      ),
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

