import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/cart_controller/cart_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final GCartController cartController = Get.find<GCartController>();

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: SizedBox(
          width: 60,
          height: 56,
          child: Center(
            child: Image.asset(
              scooter,
              width: width * 0.07,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
              text: "Cart",
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
                document,
                width: width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text("Your cart is empty."));
        }

        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Slidable(
                key: ValueKey(item.id),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        cartController.removeCartItem(item.productId);
                      },
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  width: width,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GColor.whiteGray,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: GColor.grey200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CachedNetworkImage(
                              imageUrl: "$portPhoto${item.photo}",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: ResponsiveTextStyles.nameItem(context),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              "\$${item.price.toStringAsFixed(2)}",
                              style: ResponsiveTextStyles.nameItem(context),
                            ),
                            Text(
                              "Total: \$${item.subtotal.toStringAsFixed(2)}",
                              style: ResponsiveTextStyles.nameItem(context),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: GColor.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                // onTap: () => cartController.removeCartItem(item.productId),
                                onTap: () {
                                  if (item.quantity > 1) {
                                    cartController.updateCartItemQuantity(item.productId, item.quantity - 1);
                                  } else {
                                    cartController.removeCartItem(item.productId);
                                  }
                                },
                                child: Image.asset(minus, width: 12),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${item.quantity}",
                                style: ResponsiveTextStyles.priceItem(context),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => cartController.increaseCart(item.productId, 1),
                                child: Image.asset(plus, width: 12),
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
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Obx(() => CustomButton(
          text: "Checkout (\$${cartController.total.value.toStringAsFixed(2)})",
          onPressed: () {
            if(cartController.cartItems.isNotEmpty){
              Get.toNamed(AppRoutes.checkout);
            }else{
              Get.snackbar("Can't checkout", "Add product first!");
            }
          },
        )),
      ),
    );
  }
}
