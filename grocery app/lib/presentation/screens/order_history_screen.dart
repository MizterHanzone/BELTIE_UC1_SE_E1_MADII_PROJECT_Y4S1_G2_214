import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
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
              text: "My Order",
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
                shop,
                width: width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.orderHistoryDetail);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: width,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GColor.whiteGray
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order#: 999012",
                                  style: ResponsiveTextStyles.orderNumber(context),
                                ),
                                Text(
                                  "12-July-2025 11:09AM",
                                  style: ResponsiveTextStyles.orderNumber(context),
                                ),
                                Text(
                                  "12-July-2025 11:09AM",
                                  style: ResponsiveTextStyles.deliveryDateNumber(context),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/banana.jpg",
                              width: 80,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
