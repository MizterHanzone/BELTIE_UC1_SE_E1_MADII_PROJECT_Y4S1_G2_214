import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/cart_controller/cart_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/carousel_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/category_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/product_controller.dart';
import 'package:online_grocery_delivery_app/presentation/screens/product_filter_screen.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/home_widgets/product_cart.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/home_widgets/see_all.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    // custom width and height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final GCarouselController carouselController = Get.put(GCarouselController());
    final GCategoriesController categoriesController = Get.put(GCategoriesController());
    final GProductController productController = Get.put(GProductController());
    final GCartController cartController = Get.put(GCartController());

    return Scaffold(
      backgroundColor: Colors.white,
      // app bar section
      appBar: AppBar(
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
            text: "61 Hopper Street",
            style: ResponsiveTextStyles.appBarTitle(context)
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.search);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                search,
                width: width * 0.07,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // carousel section
              Obx(() {

                // if (carouselController.photoList.isEmpty) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CarouselSlider.builder(
                    carouselController: carouselController.carouselController,
                    itemCount: carouselController.photoList.length,
                    itemBuilder: (context, index, realIdx) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: carouselController.photoList[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.8,
                      aspectRatio: 16 / 8,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        carouselController.updateIndex(index);
                      },
                    ),
                  ),
                );
              }),
              SizedBox(height: 20,),
              // list categories section
              Obx(() {

                // if (categoriesController.categories.isEmpty) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                  return SizedBox(
                    height: height * 0.15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesController.categories.length,
                      itemBuilder: (context, index) {
                        final category = categoriesController.categories[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ProductFilterScreen(category: category));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.2,
                                height: width * 0.2,
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: GColor.whiteGray,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: CachedNetworkImage(
                                      imageUrl: "$portPhoto${category.photo}",
                                    width: width * 0.15,
                                    height: width * 0.15,
                                  ),
                                ),
                              ),
                              Text(
                                category.name,
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
              // product section
              Obx(() {
                // if (productController.isLoading.value) {
                //   return CircularProgressIndicator();
                // }

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
      ),
    );
  }
}