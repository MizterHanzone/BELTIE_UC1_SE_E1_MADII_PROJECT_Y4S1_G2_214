// lib/app/modules/login/controllers/login_controller.dart

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final supabase = Supabase.instance.client;

  Future<void> handleLogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    isLoading.value = true;

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      isLoading.value = false;

      if (response.user == null) {
        Get.snackbar('Login Failed', 'User not found');
        return;
      }

      Get.snackbar('Success', 'Login successful');
      Get.offAllNamed(Routes.HOME); // or your dashboard route

    } on AuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Error', e.message);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
