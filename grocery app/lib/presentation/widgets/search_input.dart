import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchInput({
    super.key,
    this.controller,
    this.hintText = "Search your favorite",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.06,
      decoration: BoxDecoration(
        color: GColor.whiteGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          style: ResponsiveTextStyles.labelSearch(context),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: hintText,
            hintStyle: ResponsiveTextStyles.labelSearch(context),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                search,
                height: width * 0.05, // smaller icon
                color: GColor.blackGray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
