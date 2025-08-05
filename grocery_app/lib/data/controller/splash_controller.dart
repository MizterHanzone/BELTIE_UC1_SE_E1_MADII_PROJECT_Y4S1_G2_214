import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class SplashController extends GetxController {
  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.navigate); // Prevents back navigation
    });
  }
}
