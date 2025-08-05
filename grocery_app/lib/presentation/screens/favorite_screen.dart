import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/data/controller/auth_controller/auth_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/cart_controller/cart_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/favorite_controller.dart';
import 'package:online_grocery_delivery_app/presentation/screens/favorite_filter_screen.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/search_input.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  final authController = Get.find<GAuthController>();
  final favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController searchController = TextEditingController();

    final GCartController cartController = Get.find<GCartController>();

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SizedBox(
          width: 60,
          height: 56,
          child: Center(
            child: Image.asset(
              heart,
              width: width * 0.06,
              fit: BoxFit.contain,
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
              child: Obx(() {
                final cartCount = cartController.distinctProductCount.value; // Or your count variable

                return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -5, end: -5),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                    shape: badges.BadgeShape.circle,
                    padding: const EdgeInsets.all(5),
                  ),
                  badgeContent: Text(
                    '$cartCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  showBadge: cartCount > 0,  // Hide badge if count is zero
                  child: Image.asset(
                    cart,
                    width: width * 0.06,
                  ),
                );
              }),
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
                hintText: "Search your favorite",
                onChanged: (text) {
                  favoriteController.searchFavorite(text);
                },
              ),
              SizedBox(height: 10,),
              Obx(() {
                if(favoriteController.favoriteCategories.isEmpty){
                  return SizedBox();
                }
                  return SizedBox(
                    height: height * 0.10,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: favoriteController.favoriteCategories.length,
                      itemBuilder: (context, index) {
                        final categoryFavorite = favoriteController.favoriteCategories[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              FavoriteFilterScreen(favoriteCategoryModel: categoryFavorite)
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.15,
                                height: width * 0.15,
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: GColor.whiteGray,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: CachedNetworkImage(
                                      imageUrl: "$portPhoto${categoryFavorite.photo}"
                                  ),
                                ),
                              ),
                              Text(
                                categoryFavorite.name,
                                style: ResponsiveTextStyles.categoryTitle(context),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
              Obx(() {
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

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favoriteController.favorites.length,
                    itemBuilder: (context, index){
                      final favorite = favoriteController.favorites[index];
                      return Container(
                          margin: EdgeInsets.only(top: 10),
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
                                CachedNetworkImage(
                                    imageUrl: "$portPhoto${favorite.photo}",
                                  width: 100,
                                ),
                                SizedBox(width: 20,),
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
                                SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: () {
                                    favoriteController.toggleFavorite(favorite.id);
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
                                        bin,
                                        width: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () {
                                    cartController.addToCart(favorite.id, 1);
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
                        );
                    }
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
