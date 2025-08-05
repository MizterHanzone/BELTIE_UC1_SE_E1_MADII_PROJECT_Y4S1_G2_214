import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        centerTitle: true,
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
        title: RichText(
          text: TextSpan(
              text: "Notification",
              style: ResponsiveTextStyles.labelNotification(context)
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                notification,
                width: width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.notificationDetail);
                    },
                    child: Container(
                      width: width,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: GColor.whiteGray
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/banana.jpg",
                              width: 60,
                            ),
                            SizedBox(width: 20,),
                            Text(
                              "Big promotion",
                              style: ResponsiveTextStyles.labelNotificationTitle(context),
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "12-July-2025 11:09AM",
                                  style: ResponsiveTextStyles.labelNotificationDate(context),
                                ),
                                Text(
                                  "Read",
                                  style: ResponsiveTextStyles.labelNotificationRead(context),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          )
        ),
      ),
    );
  }
}
