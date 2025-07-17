import 'package:flutter/material.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: OneHubColor.white,
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
                        "Dress",
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
                            child: Image.asset(
                                "assets/images/jacket.png"
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
                ...List.generate(
                    20, (index){
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
                            color: OneHubColor.white
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
                                      child: Image.asset(
                                        "assets/images/jacket.png",
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Dress",
                                            style: TextStyle(
                                              fontFamily: "TikTokSans",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "\$249.99",
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
                                    // Heart Icon
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
                                    // Plus Icon
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
