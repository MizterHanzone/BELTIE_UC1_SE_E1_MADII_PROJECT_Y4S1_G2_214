import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/image.dart';
import 'package:one_hub_collection_app/presentation/widgets/auth_widgets/button_widget.dart';
import 'package:one_hub_collection_app/route/app_route.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                "Enter your verify code",
                style: TextStyle(
                  fontFamily: "TikTokSans",
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Check your email for code OTP",
                style: TextStyle(
                    fontFamily: "TikTokSans",
                    fontSize: 20,
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: width * 0.8,
                child: OtpTextField(
                  numberOfFields: 6, // Adjust as needed
                  borderColor: OneHubColor.black,
                  focusedBorderColor: OneHubColor.orange,
                  cursorColor: OneHubColor.orange,
                  showFieldAsBox: true,
                  fieldWidth: 40,
                  borderRadius: BorderRadius.circular(8),
                  onSubmit: (code) {},
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't get it?",
                    style: TextStyle(
                      fontFamily: "TikTokSans",
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: OneHubColor.blackGrey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Resent code",
                          style: TextStyle(
                            fontFamily: "TikTokSans",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width * 0.8,
                child: CustomButtonWidget(
                  text: "Verify",
                  backgroundColor: OneHubColor.orange,
                  textColor: OneHubColor.black,
                  onPressed: () {
                    Get.toNamed(AppRoutes.resetPassword);
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
