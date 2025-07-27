import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';
import 'package:one_hub_collection_app/core/theme/icon.dart';
import 'package:one_hub_collection_app/data/controller/bottom_nav_controller.dart';
import 'package:one_hub_collection_app/presentation/screens/cart_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/favorite_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/home_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/profile_screen.dart';

class NavigateScreen extends StatelessWidget {
  NavigateScreen({super.key});

  final BottomNavController navController = Get.put(BottomNavController());

  final List<Widget> _screens = [
    HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  final List<String> iconPaths = [
    iconHome,
    iconHeart,
    iconCart,
    iconUser,
  ];

  final List<String> labels = ['Home', 'Favorite', 'Cart', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => _screens[navController.currentIndex.value]),
      bottomNavigationBar: Obx(() => Container(
        color: Colors.black,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          elevation: 0,
          currentIndex: navController.currentIndex.value,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          onTap: navController.changeIndex,
          items: List.generate(iconPaths.length, (index) {
            final isActive = navController.currentIndex.value == index;
            return BottomNavigationBarItem(
              icon: Image.asset(
                iconPaths[index],
                height: 24,
                width: 24,
                color: isActive ? Colors.orange : Colors.white,
              ),
              label: labels[index],
            );
          }),
        )

      )),
    );
  }
}
