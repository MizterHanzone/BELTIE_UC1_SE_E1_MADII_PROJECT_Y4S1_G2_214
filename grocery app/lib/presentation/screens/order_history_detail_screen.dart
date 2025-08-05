import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  const OrderHistoryDetailScreen({super.key});

  @override
  State<OrderHistoryDetailScreen> createState() => _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {
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
              text: "Order Detail",
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Order#: 999012",
                style: ResponsiveTextStyles.orderNumberDetail(context),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 20,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Banana: 9bun",
                                    style: ResponsiveTextStyles.itemName(context),
                                  ),
                                  Text(
                                    "Total price: \$9",
                                    style: ResponsiveTextStyles.itemPrice(context),
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/images/banana.jpg",
                                width: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: 260,
        decoration: BoxDecoration(
          color: GColor.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: const [
            BoxShadow(
              color: GColor.whiteGray,
              offset: Offset(0, -4),
              blurRadius: 10,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Delivered", style: ResponsiveTextStyles.bottomLabel(context)),
                      Text("12-July-2025 11:09AM", style: ResponsiveTextStyles.bottomDate(context)),
                    ],
                  ),
                  Image.asset(cart, width: 40, color: GColor.green),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: \$180", style: ResponsiveTextStyles.bottomLabel(context)),
                  Image.asset(cart, width: 40, color: GColor.green),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GColor.white,
                  boxShadow: const [
                    BoxShadow(
                      color: GColor.whiteGray,
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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

