import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final List<String> imageList = [
    'assets/images/shirt.png',
    'assets/images/sport.png',
  ];

  String selectedColor = '';
  String selectedSize = 'lue';

  final List<String> colors = ['Red', 'Blue', 'White', 'Black', 'Black', 'Black', 'Black', 'Black'];
  final List<String> sizes = ['S', 'XS', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: OneHubColor.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){},
                  child: Image.asset(
                    iconHeart,
                    width: 30,
                  ),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      color: OneHubColor.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        iconPlus,
                        width: 30,
                        color: OneHubColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shirt",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TiTokSans"
                    ),
                  ),
                  Text(
                    "\$249.99",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "TiTokSans"
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: OneHubColor.white
                ),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                      ),
                      items: imageList.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      'Color:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    // Wrap ListView inside SingleChildScrollView to allow horizontal scrolling
                    Row(
                      children: List.generate(colors.length, (index) {
                        String color = colors[index];
                        bool isSelected = selectedColor == color;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? Colors.black : Colors.black54,
                                    width: 2,
                                  ),
                                  color: Colors.white,
                                ),
                                child: isSelected
                                    ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    color: Colors.black,
                                  ),
                                ) : null,
                              ),
                              SizedBox(width: 5),
                              Text(color),
                              SizedBox(width: 10,),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      'Size:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: List.generate(sizes.length, (index) {
                        String size = sizes[index];
                        bool isSelected = selectedSize == size;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? Colors.black : Colors.black54,
                                    width: 2,
                                  ),
                                  color: Colors.white,
                                ),
                                child: isSelected
                                    ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    color: Colors.black,
                                  ),
                                ) : null,
                              ),
                              SizedBox(width: 5),
                              Text(size),
                              SizedBox(width: 10,),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: OneHubColor.blackGrey,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 40,),
              Container(
                width: width,
                height: height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: OneHubColor.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Details:",
                        style: TextStyle(
                          fontFamily: "TikTokSans",
                          fontWeight: FontWeight.bold,
                          fontSize: 18
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
                        "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z",
                        style: TextStyle(
                            fontFamily: "TikTokSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
