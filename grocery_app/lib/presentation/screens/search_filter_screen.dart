import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/product_controller.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class SearchFilterScreen extends StatefulWidget {
  final int categoryId;
  const SearchFilterScreen({super.key, required this.categoryId,});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {

  final GProductController productController = Get.put(GProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductsByCategory(widget.categoryId);
    });
  }


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
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -4, end: -4),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.red,
                  shape: badges.BadgeShape.circle,
                  padding: const EdgeInsets.all(5),
                ),
                badgeContent: Text(
                  '3', // replace with dynamic value e.g. '${controller.cartCount}'
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Image.asset(
                  cart,
                  width: width * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (productController.products.isEmpty) {
                  return const Center(child: Text("No products found in this category."));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.productDetail,
                          arguments: product,
                          preventDuplicates: false, // Important
                        ),
                        child: Container(
                          width: width,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: GColor.whiteGray
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                    imageUrl: "$portPhoto${product.photo}",
                                    width: 80,
                                    height: 80
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                        product.name,
                                      style: TextStyle(
                                        fontFamily: "BalooDa",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18
                                      ),
                                    ),
                                    subtitle: Text(
                                        "\$${product.price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontFamily: "BalooDa",
                                        fontSize: 15,
                                        color: GColor.red
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: GColor.white
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        plus,
                                        color: GColor.blackGray,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    // return ListTile(
                    //   leading: CachedNetworkImage(imageUrl: "$portPhoto${product.photo}", width: 50, height: 50),
                    //   title: Text(product.name),
                    //   subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    // );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
