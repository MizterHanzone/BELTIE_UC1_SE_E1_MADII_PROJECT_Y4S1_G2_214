import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/home_controller/product_controller.dart';
import 'package:online_grocery_delivery_app/data/models/category_model.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/search_input.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class ProductFilterScreen extends StatefulWidget {
  final CategoryModel category;
  const ProductFilterScreen({super.key, required this.category,});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();

    final GProductController productController = Get.put(GProductController());

    // Fetch products by category when the screen loads
    productController.fetchProductsByCategory(widget.category.id);

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
                width: width * 0.06,
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
            const SizedBox(height: 10),
            SearchInput(
              controller: searchController,
              hintText: "Search your grocery",
              onChanged: (text) {
                productController.searchProducts(text);
              },
            ),
            const SizedBox(height: 20),
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
                      child: CachedNetworkImage(
                          imageUrl: "$portPhoto${widget.category.photo}",
                        width: 50,
                      )
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.category.name,
                  style: ResponsiveTextStyles.labelFilterProduct(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (productController.products.isEmpty) {
                  return const Center(child: Text("No products found"));
                }

                return GridView.builder(
                  // itemCount: productController.products.length,
                  itemCount: productController.filteredProducts.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = productController.filteredProducts[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRoutes.productDetail,
                        arguments: product,
                        preventDuplicates: false,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: GColor.whiteGray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                    imageUrl: "$portPhoto${product.photo}",
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.name,
                                style: ResponsiveTextStyles.productTitle(context),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: ResponsiveTextStyles.productRate(context),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${product.price}",
                                    style: ResponsiveTextStyles.productRate(context),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Add to cart logic here
                                    },
                                    child: Container(
                                      width: width * 0.12,
                                      height: width * 0.12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: GColor.white,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            plus,
                                            width: width * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
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
