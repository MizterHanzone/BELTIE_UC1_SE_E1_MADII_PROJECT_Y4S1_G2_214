import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/image.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/button_widget.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/text_field_email_widget.dart';
import 'package:one_hub_collection_app/route/app_route.dart';

class SendEmailScreen extends StatefulWidget {
  const SendEmailScreen({super.key});

  @override
  State<SendEmailScreen> createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController emailController = TextEditingController();

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
                "Will send code to your email",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "TikTokSans"
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: width * 0.8,
                child: TextFieldEmailWidget(
                  controller: emailController,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: width * 0.8,
                child: CustomButtonWidget(
                  text: "Send",
                  backgroundColor: OneHubColor.orange,
                  textColor: OneHubColor.black,
                  onPressed: () {
                    Get.toNamed(AppRoutes.verifyCode);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
