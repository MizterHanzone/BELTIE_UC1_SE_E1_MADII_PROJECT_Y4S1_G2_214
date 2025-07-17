import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/image.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/button_widget.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/text_field_email_widget.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/text_field_password_widget.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/text_field_widget.dart';
import 'package:one_hub_collection_app/route/app_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: OneHubColor.linear,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logoApp,
                    width: width * 0.5,
                  ),
                  const SizedBox(height: 60),
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: width * 0.8,
                    child: CustomButtonWidget(
                      text: "Register",
                      backgroundColor: OneHubColor.orange,
                      textColor: OneHubColor.black,
                      onPressed: () {
                        // login logic
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account?",
                            style: TextStyle(color: OneHubColor.black),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Login",
                            style: TextStyle(color: OneHubColor.orange),
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
      ),
    );
  }
}
