import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/bottom_nav_controller.dart';
import 'package:online_grocery_delivery_app/data/controller/cart_controller/cart_controller.dart';
import 'package:online_grocery_delivery_app/presentation/screens/cart_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/favorite_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/home_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/profile_screen.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/nav_bar_widgets/tab_bar.dart';

class NavigateScreen extends StatefulWidget {

   const NavigateScreen({super.key});

  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {

  final BottomNavController controller = Get.put(BottomNavController());

  int cartCount = 3;

  final List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final GCartController cartController = Get.put(GCartController());

    final List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: customNavItem(image: home, isSelected: false, context: context),
        activeIcon: customNavItem(context: context, image: home, isSelected: true),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Obx(() => badges.Badge(
          showBadge: cartController.distinctProductCount.value > 0,
          position: badges.BadgePosition.topEnd(top: -4, end: -4),
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.red,
            shape: badges.BadgeShape.circle,
            padding: const EdgeInsets.all(5),
          ),
          badgeContent: Text(
            '${cartController.distinctProductCount.value}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: customNavItem(
            image: cart,
            isSelected: false,
            context: context,
          ),
        )),
        activeIcon: Obx(() => badges.Badge(
          showBadge: cartController.distinctProductCount.value > 0,
          position: badges.BadgePosition.topEnd(top: -4, end: -4),
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.red,
            shape: badges.BadgeShape.circle,
            padding: const EdgeInsets.all(5),
          ),
          badgeContent: Text(
            '${cartController.distinctProductCount.value}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: customNavItem(
            image: cart,
            isSelected: true,
            context: context,
          ),
        )),
        label: 'Cart',
      ),
      BottomNavigationBarItem(
        icon: customNavItem(image: heart, isSelected: false, context: context),
        activeIcon: customNavItem(context: context, image: heart, isSelected: true),
        label: 'Favorite',
      ),
      BottomNavigationBarItem(
        icon: customNavItem(image: user, isSelected: false, context: context),
        activeIcon: customNavItem(context: context, image: user, isSelected: true),
        label: 'Profile',
      ),
    ];

    return Obx(() {
      return Scaffold(
        backgroundColor: GColor.white,
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: GColor.white,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          selectedItemColor: GColor.green,
          unselectedItemColor: GColor.black,
          selectedLabelStyle: ResponsiveTextStyles.labelNavBarSelected(context),
          unselectedLabelStyle: ResponsiveTextStyles.labelNavBarUnSelected(context),
          type: BottomNavigationBarType.fixed,
          items: navItems,
        ),
      );
    });
  }
}
