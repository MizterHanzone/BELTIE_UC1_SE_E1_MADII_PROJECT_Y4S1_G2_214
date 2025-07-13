import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar("Logout", "Logout successfully!");
    } catch (e) {
      print("Logout error: $e");
      Get.snackbar('Logout Failed', e.toString());
    }
  }
}