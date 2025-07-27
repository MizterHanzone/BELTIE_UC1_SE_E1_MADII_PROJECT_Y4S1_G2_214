import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/route/app_route.dart';

import 'data/controller/product_controller/product_controller.dart';

void main() {
  Get.put(OHProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.navigate,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
