import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

Widget customNavItem({
  required BuildContext context,
  required String image,
  required bool isSelected,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 3,
        width: isSelected ? MediaQuery.of(context).size.width * 0.15 : 0,
        decoration: BoxDecoration(
          color: GColor.green,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(height: 4),
      Image.asset(
        image,
        width: MediaQuery.of(context).size.width * 0.07,
        color: isSelected ? GColor.green : null,
      ),
    ],
  );
}
