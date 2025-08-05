import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/product_controller.dart';
import 'package:online_grocery_delivery_app/presentation/screens/search_filter_screen.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/search_input.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final TextEditingController searchController = TextEditingController();

    final GProductController productController = Get.put(GProductController());

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
              Get.toNamed(AppRoutes.cart);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SearchInput(
                controller: searchController,
                hintText: "Search your grocery",
                onChanged: (text) {
                  productController.searchProductsGuest(text);
                },
                // onChanged: (text) {
                //   productController.filterLocallyBySearch(text);
                // },
              ),
              Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productController.searchedProducts.length,
                  itemBuilder: (context, index) {
                    final product = productController.searchedProducts[index];
                    return ListTile(
                      leading: CachedNetworkImage(imageUrl: "$portPhoto${product.photo}", width: 50, height: 50,),
                      title: Text(product.name),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                      onTap: () {
                        // Get.to(() => SearchFilterScreen(categoryName: product.category));
                        Get.to(() => SearchFilterScreen(categoryId: product.categoryId));
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
