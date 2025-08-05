// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
// import 'package:online_grocery_delivery_app/core/theme/color.dart';
// import 'package:online_grocery_delivery_app/core/theme/image.dart';
// import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
// import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
// import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_email.dart';
// import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_normal.dart';
// import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_number.dart';
// import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_password.dart';
// import 'package:online_grocery_delivery_app/route/app_route.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final GAuthController authController = GAuthController();
//
//   @override
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GColor.white,
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: IgnorePointer(
//               child: Image.asset(
//                 flavour,
//                 fit: BoxFit.cover,
//                 width: MediaQuery.of(context).size.width,
//                 height: 180, // Adjust height as needed
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 100),
//                 Text(
//                   "Register now!",
//                   style: ResponsiveTextStyles.authTitle(context),
//                 ),
//                 Text(
//                   "Create your account for new experience!",
//                   style: ResponsiveTextStyles.authDescription(context),
//                 ),
//                 const SizedBox(height: 20),
//                 TextBoxNormal(controller: firstNameController, label: 'First name'),
//                 const SizedBox(height: 20),
//                 TextBoxNormal(controller: lastNameController, label: 'Last name'),
//                 const SizedBox(height: 20),
//                 TextBoxEmail(controller: emailController,),
//                 const SizedBox(height: 20),
//                 TextBoxNumber(controller: phoneController, label: "Phone number", isNumber: true,),
//                 const SizedBox(height: 20),
//                 TextBoxPassword(controller: passwordController),
//                 const SizedBox(height: 30),
//                 Obx(() => CustomButton(
//                   text: authController.isLoading.value ? "Registering ..." : "Register",
//                   onPressed: authController.isLoading.value
//                       ? null
//                       : () {
//                     final firstName = firstNameController.text.trim();
//                     final lastName = lastNameController.text.trim();
//                     final email = emailController.text.trim();
//                     final phone = phoneController.text.trim();
//                     final password = passwordController.text.trim();
//
//                     if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
//                       Get.snackbar('Validation Error', 'All field are required',
//                           snackPosition: SnackPosition.TOP,
//                           backgroundColor: Colors.orange.shade300);
//                       return;
//                     }
//
//                     authController.firstName.value = firstName;
//                     authController.lastName.value = lastName;
//                     authController.email.value = email;
//                     authController.phone.value = phone;
//                     authController.password.value = password;
//
//                     authController.register();
//
//                   }
//                 ),),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have account? ",
//                       style: ResponsiveTextStyles.authNormalText(context),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.toNamed(AppRoutes.login);
//                       },
//                       child: Text(
//                         "Login!",
//                         style: ResponsiveTextStyles.authNormalText(context).copyWith(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 200),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_email.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_normal.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_number.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_password.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GAuthController authController = GAuthController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerWithFirebase() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'All fields are required',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.shade300,
      );
      return;
    }

    try {
      authController.isLoading.value = true;

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName('$firstName $lastName');
        await user.reload();

        Get.snackbar(
          'Success',
          'Registration successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.navigate);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed. Please try again.';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use.';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      }

      Get.snackbar(
        'Registration Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      authController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GColor.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Image.asset(
                flavour,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 180,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Register now!",
                  style: ResponsiveTextStyles.authTitle(context),
                ),
                Text(
                  "Create your account for new experience!",
                  style: ResponsiveTextStyles.authDescription(context),
                ),
                const SizedBox(height: 20),
                TextBoxNormal(controller: firstNameController, label: 'First name'),
                const SizedBox(height: 20),
                TextBoxNormal(controller: lastNameController, label: 'Last name'),
                const SizedBox(height: 20),
                TextBoxEmail(controller: emailController),
                const SizedBox(height: 20),
                TextBoxNumber(controller: phoneController, label: "Phone number", isNumber: true),
                const SizedBox(height: 20),
                TextBoxPassword(controller: passwordController),
                const SizedBox(height: 30),
                Obx(() => CustomButton(
                  text: authController.isLoading.value ? "Registering ..." : "Register",
                  onPressed: authController.isLoading.value
                      ? null
                      : _registerWithFirebase,
                )),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account? ",
                      style: ResponsiveTextStyles.authNormalText(context),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(
                        "Login!",
                        style: ResponsiveTextStyles.authNormalText(context).copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
