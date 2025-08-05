import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

class SettingItem extends StatelessWidget {
  final String iconImage;
  final String title;
  final String trailingImage;
  final Color backgroundColor;
  final VoidCallback onTap;

  const SettingItem({
    super.key,
    required this.iconImage,
    required this.title,
    required this.trailingImage,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: 80,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: backgroundColor,
              ),
              child: Center(
                child: Image.asset(
                  iconImage,
                  width: 40,
                  color: GColor.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: ResponsiveTextStyles.labelItemProfileList(context),
              ),
            ),
            Image.asset(
              trailingImage,
              width: 35,
              height: 35,
              color: GColor.blackGray,
            ),
          ],
        ),
      ),
    );
  }
}
