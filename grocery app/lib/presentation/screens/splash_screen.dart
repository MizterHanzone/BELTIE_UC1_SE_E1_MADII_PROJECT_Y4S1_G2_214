import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/data/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SplashController());
    controller.navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GColor.white,
      body: Center(
        child: Text(
          "Grabber",
          style: ResponsiveTextStyles.splashTitle(context),
        ),
      ),
    );
  }
}
