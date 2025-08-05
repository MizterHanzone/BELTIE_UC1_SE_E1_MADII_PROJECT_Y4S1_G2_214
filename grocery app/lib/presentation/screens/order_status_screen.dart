import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
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
            Get.toNamed(AppRoutes.navigate);
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
              text: "Order Status",
              style: ResponsiveTextStyles.labelNotification(context)
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: Image.asset(
            document,
          width: 200,
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: GColor.blackGray.withOpacity(0.3),
              blurRadius: 20, // Smooth blur
              spreadRadius: 1, // Shadow size
              offset: const Offset(0, -5),
            ),
          ],
          color: GColor.whiteGray
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your order is delivered",
                    style: ResponsiveTextStyles.labelMessageOrderStatus(context),
                  ),
                  Image.asset(
                    shopping,
                    width: 35,
                    color: GColor.green,
                  ),
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: GColor.blackGray.withOpacity(0.3),
                      blurRadius: 10, // Smooth blur
                      spreadRadius: 1, // Shadow size
                      offset: const Offset(0, -1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: GColor.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(clock, width: 25, color: GColor.green,),
                          Text("Confirmed", style: ResponsiveTextStyles.labelStatus(context)),
                        ],
                      ),
                      _buildStepConnector(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(cart, width: 25, color: GColor.green,),
                          Text("Preparing", style: ResponsiveTextStyles.labelStatus(context)),
                        ],
                      ),
                      _buildStepConnector(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(scooter, width: 25, color: GColor.green,),
                          Text("delivering", style: ResponsiveTextStyles.labelStatus(context)),
                        ],
                      ),
                      _buildStepConnector(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ready, width: 25, color: GColor.green,),
                          Text("Delivered", style: ResponsiveTextStyles.labelStatus(context)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildStepConnector() {
  return Container(
    width: 25,
    height: 2,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: GColor.green,
    ),
  );
}
