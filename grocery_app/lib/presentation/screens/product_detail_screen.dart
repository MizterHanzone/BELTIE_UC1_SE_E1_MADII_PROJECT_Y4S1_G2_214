import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/cart_controller/cart_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/favorite_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/product_controller.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/home_widgets/product_cart.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/home_widgets/see_all.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final product = Get.arguments;
    final GProductController productController = Get.put(GProductController());
    final favoriteController = Get.put(FavoriteController());
    final GCartController cartController = Get.find<GCartController>();

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
            onTap: () {
              favoriteController.toggleFavorite(product.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Obx(() {
                final isFavorite = favoriteController.favoriteProductIds.contains(product.id);

                return GestureDetector(
                  onTap: () {
                    favoriteController.toggleFavorite(product.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Image.asset(
                      isFavorite ? heartRed : heart,
                      width: width * 0.06,
                    ),
                  ),
                );
              }),
            ),
          ),
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
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                color: GColor.whiteGray
              ),
              child: Center(
                child: SizedBox(
                  width: width * 0.5,
                  child: Hero(
                    tag: product.id,
                    child: CachedNetworkImage(
                      imageUrl: "$portPhoto${product.photo}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    product.description,
                    style: ResponsiveTextStyles.productDescription(context),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: ResponsiveTextStyles.productTitleDetail(context),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            star,
                            width: width * 0.05,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "${product.rating} (${product.favoriteCount})",
                            style: ResponsiveTextStyles.productRate(context),
                          ),
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\$${product.price} / ${product.uom}",
                      style: ResponsiveTextStyles.productPriceOnDetail(context),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Obx(() {
                    if (productController.isLoading.value) {
                      return CircularProgressIndicator();
                    }

                    return Column(
                      children: [
                        ...productController.categoryList.map((category) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SeeAllRow(title: category.categoryName,),
                              SizedBox(
                                height: height * 0.32,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: category.products.length,
                                  itemBuilder: (_, index) {
                                    final product = category.products[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ProductCart(
                                        imagePath: '$portPhoto${product.photo}',
                                        name: product.name,
                                        price: "\$${product.price}",
                                        rating: product.rating,
                                        reviewCount: product.favoriteCount,
                                        onTap: () => Get.toNamed(
                                          AppRoutes.productDetail,
                                          arguments: product,
                                          preventDuplicates: false, // Important
                                        ),
                                        onAdd: () {
                                          cartController.addToCart(product.id, 1);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.08,
        decoration: BoxDecoration(
          color: GColor.white,
          boxShadow: const [
            BoxShadow(
              color: GColor.whiteGray,
              offset: Offset(0, -1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "\$${product.price}",
              style: ResponsiveTextStyles.productPriceOnDetail(context),
            ),
            GestureDetector(
              onTap: (){
                cartController.addToCart(product.id, 1);
              },
              child: Container(
                width: width * 0.4,
                height: height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GColor.green
                ),
                child: Center(
                  child: Text(
                    "Add Cart",
                    style: ResponsiveTextStyles.labelAddCart(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
