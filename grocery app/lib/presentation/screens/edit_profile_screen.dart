import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_email.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_normal.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/text_box_number.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final GAuthController authController = Get.find<GAuthController>();

  @override
  void initState() {
    super.initState();
    authController.fetchUserProfile().then((_) {
      firstNameController.text = authController.firstName.value;
      lastNameController.text = authController.lastName.value;
      emailController.text = authController.email.value;
      phoneController.text = authController.phone.value;
    });
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: SizedBox(
            width: 60,
            height: 56,
            child: Center(
              child: Image.asset(
                arrowLeft,
                width: width * 0.05,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Get.toNamed(AppRoutes.login); // Navigation code
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                user,  // Replace with your image path
                width: width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: Obx( () {

        if (!authController.isProfileLoaded.value) {
          return const Center(child: CircularProgressIndicator());
        }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Edit profile",
                      style: ResponsiveTextStyles.labelEdit(context),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: GColor.green, width: 2),
                        ),
                        child: ClipOval(
                          child: Obx(() {
                            return authController.photoUrl.value.isNotEmpty ? CachedNetworkImage(
                              imageUrl: authController.photoUrl.value,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            )
                                : Image.asset(
                              user,
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: (){
                            authController.pickPhoto();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: GColor.white, width: 1),
                            ),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: GColor.red
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  camera,
                                  color: GColor.white,
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextBoxNormal(
                      controller: firstNameController,
                    label: "First name",
                  ),
                  SizedBox(height: 10,),
                  TextBoxNormal(
                      controller: lastNameController,
                    label: "Last name",
                  ),
                  SizedBox(height: 10,),
                  TextBoxEmail(
                      controller: emailController,
                    label: "Email",
                  ),
                  SizedBox(height: 10,),
                  TextBoxNumber(
                    controller: phoneController,
                    label: "Phone",
                    isNumber: true,
                  ),
                  SizedBox(height: 20,),
                  CustomButton(
                      text: "Update",
                      onPressed: () {
                        final firstName = firstNameController.text.trim();
                        final lastName = lastNameController.text.trim();
                        final email = emailController.text.trim();
                        final phone = phoneController.text.trim();

                        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty) {
                          Get.snackbar("Error", "All fields are required",
                              backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }

                        authController.updateProfile(
                            newFirstName: firstName,
                            newLastName: lastName,
                            newEmail: email,
                            newPhone: phone
                        );
                      }
                  ),
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: Image.asset(
          flavour,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
