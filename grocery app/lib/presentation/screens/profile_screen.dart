import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/profile_widgets/setting_item.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late var authController = Get.find<GAuthController>();

  @override
  void initState() {
    super.initState();
    authController = Get.find<GAuthController>();

    Future.microtask(() {
      authController.trackTokenStatus();

      if (!authController.isLoggedIn.value) {
        // Show dialog if not logged in
        Get.dialog(
          AlertDialog(
            title: Text("Not Logged In"),
            content: Text("Please log in to continue."),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  Get.toNamed(AppRoutes.login);
                },
                child: Text("Login"),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      if (authController.isCheckingLogin.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!authController.isLoggedIn.value) {
        return Center(
          child: Image.asset(
            vegetables,
            width: 200,
          ),
        );
      }
      return Scaffold(
          backgroundColor: GColor.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "My profile",
              style: ResponsiveTextStyles.labelItemProfileTitle(context),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.editProfile);
                  },
                  child: Container(
                    width: width,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GColor.whiteGray,
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Container(
                            width: width * 0.2,
                            height: width * 0.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: GColor.white,
                                width: 4,
                              ),
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
                          SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                  authController.name.value,
                                  style: ResponsiveTextStyles.labelUserName(context)
                              ),),
                              // Optional: Add subtitle or other content
                              Obx(() => Text(
                                  authController.email.value,
                                  style: ResponsiveTextStyles.labelEmail(context)
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SettingItem(
                  iconImage: key,
                  title: "Change password",
                  trailingImage: arrowRightOne,
                  backgroundColor: GColor.yellow,
                  onTap: () {
                    Get.toNamed(AppRoutes.sendEmail);
                  },
                ),
                SettingItem(
                  iconImage: notification,
                  title: "Notification",
                  trailingImage: arrowRightOne,
                  backgroundColor: GColor.darkBlue,
                  onTap: () {
                    Get.toNamed(AppRoutes.notification);
                  },
                ),
                SettingItem(
                  iconImage: list,
                  title: "Order History",
                  trailingImage: arrowRightOne,
                  backgroundColor: GColor.darkBlue,
                  onTap: () {
                    Get.toNamed(AppRoutes.orderHistory);
                  },
                ),
                SettingItem(
                  iconImage: term,
                  title: "Term and Condition",
                  trailingImage: arrowRightOne,
                  backgroundColor: GColor.whiteBlue,
                  onTap: () {
                    // Handle tap
                  },
                ),
                SettingItem(
                  iconImage: address,
                  title: "Address",
                  trailingImage: arrowRightOne,
                  backgroundColor: GColor.purple,
                  onTap: () {
                    Get.toNamed(AppRoutes.address);
                  },
                ),
                SettingItem(
                  iconImage: logout,
                  title: "Logout",
                  trailingImage: arrowRightOne,
                  backgroundColor: GColor.red,
                  onTap: () {
                    authController.logout();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
