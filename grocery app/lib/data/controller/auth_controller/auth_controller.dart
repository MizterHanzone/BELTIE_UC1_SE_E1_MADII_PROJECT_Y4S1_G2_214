import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/presentation/screens/navigate_screen.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class GAuthController extends GetxController {

  var isLoading = false.obs;
  final storage = GetStorage();

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString role = ''.obs;
  RxString photoUrl = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit(){
    super.onInit();
    trackTokenStatus();
  }

  // track login status
  RxBool isLoggedIn = false.obs;
  RxBool isCheckingLogin = true.obs;
  void trackTokenStatus() {
    isCheckingLogin.value = true;

    final token = storage.read('token');
    isLoggedIn.value = token != null && token.toString().isNotEmpty;

    if (isLoggedIn.value) {
      fetchUserProfile();
    }

    isCheckingLogin.value = false;
  }

  // register method
  Future<void> register() async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("${portApi}register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'first_name': firstName.value.trim(),
          'last_name': lastName.value.trim(),
          'email': email.value.trim(),
          'password': password.value,
          'phone': phone.value.trim(),
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        storage.write('token', token);

        Get.offAllNamed(AppRoutes.navigate);
      } else {
        final error = jsonDecode(response.body);
        print("Error: $error");
        Get.snackbar("Failed", error['message'] ?? "Registration failed",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: GColor.red,
            colorText: GColor.white);
      }
    } on SocketException {
      Get.dialog(
        AlertDialog(
          title: Text("No Connection"),
          content: Text("Please check your internet connection."),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("OK"),
            )
          ],
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: GColor.red,
        colorText: GColor.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // login method
  Future<void> login(String email, String password) async {
    try{

      final response = await http.post(
        Uri.parse("${portApi}login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (kDebugMode) {
        print("Status: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Body: ${response.body}");
      }

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if(response.statusCode == 200 && responseData['success']){

        final token = responseData['token'];
        final userInfo = responseData['user_info'];
        final userId = userInfo['id'];

        await storage.write('token', token);
        await storage.write('user', userInfo);
        await storage.write('userId', userId);
        // fetchLoginStatus();


        // Update observable variables
        isLoggedIn.value = true;
        name.value = userInfo['name'];
        phone.value = userInfo['phone'];
        photoUrl.value = userInfo['photo'] ?? '';

        if (kDebugMode) {
          print("GToken: $token");
        }
        if (kDebugMode) {
          print("GUser: $userInfo");
        }
        if (kDebugMode) {
          print("GUserId: $userId");
        }

        // Get.offAllNamed(AppRoutes.profile);
        Get.offAll(() => const NavigateScreen());

      }else{
        isLoading.value = false;
        Get.snackbar('Login Failed', responseData['message'] ?? 'Invalid credentials', snackPosition: SnackPosition.BOTTOM, backgroundColor: GColor.red);
      }

    } on SocketException catch (_) {
      Get.dialog(
          AlertDialog(
            title: Text("No Connection"),
            content: Text("Please check your internet connection."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text("OK"),
              )
            ],
          )
      );
    } finally {
      isLoading.value = false;
    }
  }

  // logout method
  Future<void> logout() async {
    final token = storage.read('token');
    try {
      final response = await http.post(
        Uri.parse("${portApi}logout"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        // Clear local storage
        await storage.erase();

        // Reset controller values
        isLoggedIn.value = false;
        name.value = '';
        email.value = '';
        phone.value = '';
        photoUrl.value = '';

        Get.offAllNamed(AppRoutes.navigate);
      } else {
        Get.snackbar('Logout Failed', responseData['message'] ?? 'Please try again');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong during logout');
      if (kDebugMode) {
        print("Logout error: $e");
      }
    }
  }

  // fetch user logged information
  var isProfileLoaded = false.obs;
  Future<void> fetchUserProfile() async {
    final token = storage.read('token');
    if (token == null || token.toString().isEmpty) return;
    try {
      isProfileLoaded.value = true;
      final response = await http.get(
        Uri.parse("${portApi}get-own-user"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final user = body['user'];

        firstName.value = user['first_name'] ?? '';
        lastName.value = user['last_name'] ?? '';
        name.value = user['name'] ?? '';
        email.value = user['email'] ?? '';
        role.value = user['role'] ?? '';
        phone.value = user['phone'] ?? '';
        photoUrl.value = "$portPhoto${user['photo_url'] ?? ''}";
      } else {
        if (kDebugMode) {
          print('Failed to load user profile');
        }
      }
    } catch (e) {
      isProfileLoaded.value = false;
      if (kDebugMode) {
        print('Error fetching profile: $e');
      }
    }
  }

  // Update profile function
  Future<void> updateProfile({
    required String newFirstName,
    required String newLastName,
    required String newEmail,
    required String newPhone,
    File? photo,
  }) async {
    final token = storage.read('token');

    try {
      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      // Prepare headers and body
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'first_name': newFirstName,
        'last_name': newLastName,
        'email': newEmail,
        'phone': newPhone,
      });

      // Send profile update request
      final response = await http.post(
        Uri.parse('${portApi}update-profile'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Optionally upload image
        if (photo != null) {
          await _uploadPhoto(token, photo);
        }

        // Update local values
        firstName.value = newFirstName;
        lastName.value = newLastName;
        email.value = newEmail;
        phone.value = newPhone;

        Get.back(); // Close loading
        Get.snackbar("Success", "Profile updated successfully!",
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
        );
      } else {
        Get.back();
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Failed to update profile: $e",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
    }
  }

  // select photo from gallery
  File? selectedPhoto;
  // Pick photo from gallery
  void pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedPhoto = File(picked.path);
      update(); // For GetBuilder
      final token = storage.read('token'); // Read token
      if (token != null) {
        await _uploadPhoto(token, selectedPhoto!); // Upload the photo
      }
    }
  }

  // update photo user logged
  Future<void> _uploadPhoto(String token, File photo) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${portApi}upload/profile/photo'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        await http.MultipartFile.fromPath('photo', photo.path),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final resBody = await response.stream.bytesToString();
        final decoded = jsonDecode(resBody);
        photoUrl.value = decoded['photo_url'] ?? '';
      } else {
        throw Exception("Photo upload failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload photo: $e",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
    }
  }

  // send code to email for reset password
  Future<void> sendCodeToEmail(String emailInput) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("${portApi}send-password-reset-code"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": emailInput}),
      );

      if (response.statusCode == 200) {
        email.value = emailInput; // ✅ Save for later use
        Get.toNamed(AppRoutes.verifyCode);
      } else {
        final data = jsonDecode(response.body);
        final msg = data['message'] ?? "Something went wrong";
        Get.snackbar("Error", msg);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send reset code");
    } finally {
      isLoading.value = false;
    }
  }

  // verify code for reset password
  final otpCode = ''.obs;

  Future<void> verifyCode(String codeInput) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse("${portApi}verify-password-code"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"code": codeInput}),
      );

      if (response.statusCode == 200) {
        otpCode.value = codeInput;
        Get.toNamed(AppRoutes.resetPassword);
      } else {
        final data = jsonDecode(response.body);
        final msg = data['message'] ?? "Invalid or expired code";
        Get.snackbar("Error", msg,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to verify code",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // reset password
  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    try{
      isLoading.value = true;
      final response = await http.post(
        Uri.parse("${portApi}reset-password"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "new_password": newPassword,
          "confirm_password": confirmPassword,
        }),
      );

      if(response.statusCode == 200){
        Get.snackbar(
          "Success",
          "Password reset successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to reset password",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}