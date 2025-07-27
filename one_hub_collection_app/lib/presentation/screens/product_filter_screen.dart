import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/constant/url_connection.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';
import 'package:one_hub_collection_app/data/controller/product_controller/product_controller.dart';
import 'package:one_hub_collection_app/data/model/category_model.dart';

class ProductFilterScreen extends StatefulWidget {
  final CategoryModel category;
  const ProductFilterScreen({super.key, required this.category});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final OHProductController productController = Get.put(OHProductController());

    // Fetch products by category when the screen loads
    productController.fetchProductsByCategory(widget.category.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: OneHubColor.white,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: SizedBox(
            width: 60,
            height: 56,
            child: Center(
              child: Image.asset(
                iconPlus,
                width: width * 0.06,
                fit: BoxFit.contain,
              ),
            ),
          ),
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
        height: height,
        decoration: BoxDecoration(
          gradient: OneHubColor.linear1
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontFamily: "TikTokSans",
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.category.name,
                        style: TextStyle(
                            fontFamily: "TikTokSans",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 50,
                        height: 50,
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
                                imageUrl: "$portPhoto${widget.category.photo}"
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(
                    color: OneHubColor.blackGrey,
                    height: 2.0,
                  ),
                ),
                SizedBox(height: 20,),
                Obx(() {
                  return Column(
                    children: List.generate(productController.filteredProducts.length, (index) {
                      final product = productController.filteredProducts[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: width,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: -2,
                              ),
                            ],
                            color: OneHubColor.white,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: OneHubColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Product Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                          imageUrl: "$portPhoto${product.photo}",
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: TextStyle(
                                              fontFamily: "TikTokSans",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "\$${product.price}",
                                            style: TextStyle(
                                              fontFamily: "TikTokSans",
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Floating icons (heart and plus)
                              Positioned(
                                bottom: 32,
                                right: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        iconHeart,
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Image.asset(
                                        iconPlus,
                                        width: 24,
                                        height: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
