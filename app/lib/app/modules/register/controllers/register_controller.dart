import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final isLoading = false.obs;
  final supabase = Supabase.instance.client;

  // Call this from the view
  Future<void> handleRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all the fields');
      return;
    }

    isLoading.value = true;

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      isLoading.value = false;

      if (response.user == null) {
        Get.snackbar('Error', 'Signup failed: No user created');
        return;
      }

      Get.snackbar('Success', 'Account created successfully!');
      Get.toNamed(Routes.LOGIN);
    } on AuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Signup Failed', e.message);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Unexpected Error', e.toString());
    }
  }
}
