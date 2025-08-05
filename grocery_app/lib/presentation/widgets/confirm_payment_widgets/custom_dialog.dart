import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

void showOrderSuccessDialog() {
  Get.generalDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {

      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.orderStatus);
      });

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 120,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Order Successful!",
                    style: ResponsiveTextStyles.labelMessageOrderSuccess(context)
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Thank you for your purchase.\nYour order has been placed successfully.",
                    textAlign: TextAlign.center,
                    style: ResponsiveTextStyles.labelMessageOrder(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
