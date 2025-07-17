import 'package:flutter/material.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/image.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/button_widget.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/text_field_password_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController passwordController =TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: OneHubColor.orange,
      ),
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
              SizedBox(height: height * 0.01),
              Text(
                "Reset Password",
                style: TextStyle(
                    fontFamily: "TikTokSans",
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Change your secret password",
                style: TextStyle(
                  fontFamily: "TikTokSans",
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: width * 0.8,
                child: TextFieldPasswordWidget(
                  hintText: "Password",
                  controller: passwordController,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width * 0.8,
                child: CustomButtonWidget(
                  text: "Reset",
                  backgroundColor: OneHubColor.orange,
                  textColor: OneHubColor.black,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
