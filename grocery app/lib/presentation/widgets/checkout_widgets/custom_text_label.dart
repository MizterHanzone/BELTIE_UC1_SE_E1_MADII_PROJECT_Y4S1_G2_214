import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

class CustomTextLabel extends StatelessWidget {
  final String hintText;
  final String? prefixImagePath;
  final String? suffixImagePath;
  final VoidCallback? onTap;

  const CustomTextLabel({
    super.key,
    required this.hintText,
    this.prefixImagePath,
    this.suffixImagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: GColor.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (prefixImagePath != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  prefixImagePath!,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  color: GColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if (suffixImagePath != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Image.asset(
                  suffixImagePath!,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
