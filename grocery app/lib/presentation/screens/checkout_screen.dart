import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/address_controller/address_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/cart_controller/cart_controller.dart';
import 'package:online_grocery_delivery_app/data/models/address_model.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/checkout_widgets/custom_text_label.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final GAddress addressController = Get.put(GAddress());
    final GCartController cartController = Get.put(GCartController());
    final GAuthController authController = Get.put(GAuthController());

    double bagFee(double total) => total * 0.1;
    double serviceFee(double total) => total * 0.2;
    double deliveryFee(double total) => total * 0.2;

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
              text: "Checkout",
              style: ResponsiveTextStyles.labelNotification(context)
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Details",
              style: ResponsiveTextStyles.labelDetailCheckout(context),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){},
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: CustomTextLabel(
                  hintText: "${authController.name}",
                  prefixImagePath: user,
                  suffixImagePath: arrowRightOne,
                  onTap: (){
                    Get.toNamed(AppRoutes.editProfile);
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  border: const Border(
                    left: BorderSide(color: GColor.grey200, width: 1),
                    right: BorderSide(color: GColor.grey200, width: 1),
                    bottom: BorderSide(color: GColor.grey200, width: 1),
                    top: BorderSide.none,
                  ),
                ),
                child: CustomTextLabel(
                  hintText: "${authController.phone}",
                  prefixImagePath: telephone,
                  suffixImagePath: arrowRightOne,
                  onTap: (){
                    Get.toNamed(AppRoutes.editProfile);
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Address",
              style: ResponsiveTextStyles.labelDetailCheckout(context),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.addressUpdate);
              },
              child: Container(
                width: width,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border(
                    left: BorderSide(color: GColor.grey200, width: 1),
                    right: BorderSide(color: GColor.grey200, width: 1),
                    top: BorderSide(color: GColor.grey200, width: 1),
                    bottom: BorderSide(color: GColor.grey200, width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        location,
                        width: 25,
                      ),
                      SizedBox(width: 10,),
                      Obx(() {

                        UserAddress address = addressController.addresses.first;

                          return Text(
                            "${address.district} , ${address.province}",
                            style: ResponsiveTextStyles.labelAddressCheckout(context),
                          );
                        }
                      ),
                      Spacer(),
                      Image.asset(
                        arrowRightOne,
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Order Summary (${cartController.count} items)",
              style: ResponsiveTextStyles.labelDetailCheckout(context),
            ),
            SizedBox(height: 20,),
            Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: GColor.grey200),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                        Text(
                          "\$${cartController.total}",
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: GColor.whiteGray,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bag fee",
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                        Text(
                          bagFee(cartController.total.value).toStringAsFixed(2),
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: GColor.whiteGray,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service Fee",
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                        Text(
                            serviceFee(cartController.total.value).toStringAsFixed(2),
                            style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: GColor.whiteGray,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                        Text(
                          deliveryFee(cartController.total.value).toStringAsFixed(2),
                          style: ResponsiveTextStyles.labelSubAmount(context),
                        ),
                      ],
                    ),
                   ),
                  Divider(height: 1, color: GColor.whiteGray,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: ResponsiveTextStyles.labelTotalAmount(context),
                        ),
                        Text(
                          "\$${((cartController.total.value)
                              + (cartController.total.value * 0.1)
                              + (cartController.total.value * 0.2)
                              + (cartController.total.value * 0.2)).toStringAsFixed(2)}",
                          style: ResponsiveTextStyles.labelTotalAmount(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomButton(
            text: "Checkout",
            onPressed: (){
              Get.toNamed(AppRoutes.confirmPayment);
            }
        ),
      ),
    );
  }
}
