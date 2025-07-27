import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/constant/url_connection.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';
import 'package:one_hub_collection_app/core/theme/image.dart';
import 'package:one_hub_collection_app/data/controller/category_controller/category_controller.dart';
import 'package:one_hub_collection_app/data/controller/product_controller/product_controller.dart';
import 'package:one_hub_collection_app/presentation/screens/product_filter_screen.dart';
import 'package:one_hub_collection_app/route/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final OHCategoryController categoriesController = Get.put(OHCategoryController());
  final OHProductController productController = Get.put(OHProductController());

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: OneHubColor.white,
      appBar: AppBar(
        backgroundColor: OneHubColor.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              logoApp,
              height: 80,
              fit: BoxFit.contain,
            ),

            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    // handle notification tap
                  },
                  icon: Image.asset(
                    iconNotification,
                    height: 28,
                    width: 28,
                  ),
                ),
                // Badge
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: OneHubColor.blackGrey,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: OneHubColor.linear1,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                "Categories",
                style: TextStyle(
                  fontFamily: "TikTokSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),
              Obx(() {
                if(categoriesController.categories.isEmpty){
                  return Center(
                    child: Text("Not found categories"),
                  );
                }
                  return SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesController.categories.length,
                      itemBuilder: (context, index) {
                        final categories = categoriesController.categories[index];
                        return GestureDetector(
                          onTap: (){
                            Get.to(ProductFilterScreen(category: categories));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: OneHubColor.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 4),
                                          blurRadius: 6,
                                          spreadRadius: -2,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: CachedNetworkImage(
                                            imageUrl: "$portPhoto${categories.photo}",
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    categories.name,
                                    style: TextStyle(
                                      fontFamily: 'TikTokSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
              SizedBox(height: 10,),
              PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: OneHubColor.blackGrey,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Product List",
                style: TextStyle(
                    fontFamily: "TikTokSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (productController.products.isEmpty) {
                  return const Center(child: Text("No products found"));
                }

                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      final product = productController.products[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.productDetail,
                          arguments: product,
                          preventDuplicates: false,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: OneHubColor.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: "$portPhoto${product.photo}",
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      width: 100,
                                      height: 150,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "\$${product.price}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: OneHubColor.orange,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Image.asset(
                                                iconPlus,
                                                color: OneHubColor.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image.asset(
                                      iconHeart,
                                      width: 20,
                                      color: OneHubColor.blackGrey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
