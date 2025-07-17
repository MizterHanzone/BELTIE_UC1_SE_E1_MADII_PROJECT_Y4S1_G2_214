import 'package:flutter/material.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: OneHubColor.white,
        title: Text(
          "Cart",
          style: TextStyle(),
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
          child: ListView.builder(
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: width,
                    height: 200,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Image.asset(
                                    "assets/images/jacket.png"
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Red Dress",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "TikTokSans"
                                    ),
                                  ),
                                  Text(
                                    "Color: Red",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: "TikTokSans"
                                    ),
                                  ),
                                  Text(
                                    "Size: M",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: "TikTokSans"
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Text(
                                        "249.99",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: "TikTokSans"
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      GestureDetector(
                                        onTap: (){},
                                        child: Image.asset(
                                          iconMinus,
                                          width: 15,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        width: 40,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: OneHubColor.orange
                                        ),
                                        child: Center(
                                          child: Text(
                                            "01",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: "TikTokSans"
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){},
                                        child: Image.asset(
                                          iconPlus,
                                          width: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: (){},
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    iconCross,
                                    width: 20,
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    )
                  ),
                );
              }
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: OneHubColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, -4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              buildRow(context, "Delivery Fee", "\$24.00"),
              SizedBox(height: 10,),
              buildRow(context, "Tax", "\$225.99"),
              SizedBox(height: 10,),
              buildRow(context, "Sub total", "\$70.00"),
              SizedBox(height: 10,),
              PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: OneHubColor.blackGrey,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 10,),
              buildRow(context, "Total", "\$239.99"),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: OneHubColor.orange,
                  ),
                  child: Center(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontFamily: "TikTokSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: OneHubColor.white,
                      ),
                    ),
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

Widget buildRow(BuildContext context, String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
