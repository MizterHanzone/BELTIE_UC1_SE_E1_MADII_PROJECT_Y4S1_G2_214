import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';
import 'package:one_hub_collection_app/core/theme/image.dart';
import 'package:one_hub_collection_app/route/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.productFilter);
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
                                    child: Image.asset(
                                      "assets/images/jacket.png"
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "ONE",
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
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.productDetail);
                        },
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
                                    Image.asset(
                                      "assets/images/jacket.png"
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Shirt",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                                "\$249.99",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: OneHubColor.orange
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
                                      onTap: (){},
                                      child: Image.asset(
                                        iconHeart,
                                        width: 20,
                                        color: OneHubColor.blackGrey,
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
