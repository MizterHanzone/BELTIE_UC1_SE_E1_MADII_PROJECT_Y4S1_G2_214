import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/favorite_controller.dart';
import 'package:online_grocery_delivery_app/data/models/favorite_category_model.dart';

class FavoriteFilterScreen extends StatefulWidget {
  final FavoriteCategoryModel favoriteCategoryModel;
  const FavoriteFilterScreen({super.key, required this.favoriteCategoryModel});

  @override
  State<FavoriteFilterScreen> createState() => _FavoriteFilterScreenState();
}

class _FavoriteFilterScreenState extends State<FavoriteFilterScreen> {

  @override
  void initState() {
    super.initState();
    final categoryId = widget.favoriteCategoryModel.id;
    Get.find<FavoriteController>().filterFavoritesByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final favoriteController = Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        backgroundColor: GColor.white,
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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Image.asset(
                    heartRed,
                    width: width * 0.06,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: GColor.whiteGray,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Image.asset(
                          vegetables
                        ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Vegetable",
                  style: ResponsiveTextStyles.labelFilterProduct(context),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {

                if (favoriteController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (favoriteController.filteredFavorites.isEmpty) {
                  return Center(child: Text("No favorites in this category"));
                }

                  return ListView.builder(
                  itemCount: favoriteController.filteredFavorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favoriteController.filteredFavorites[index];

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: width,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: GColor.whiteGray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              // Load product image from network
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                    imageUrl: "$portPhoto${favorite.photo}",
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Product details
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      favorite.name,
                                      style: ResponsiveTextStyles.productTitle(context),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "\$${favorite.price}",
                                      style: ResponsiveTextStyles.productTitle(context),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Add button
                              GestureDetector(
                                onTap: () {
                                  // Add to cart logic here
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: GColor.white,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      plus,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    ),
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
            )
          ],
        ),
      ),
    );
  }
}
