import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';

class ProductCart extends StatelessWidget {
  final String imagePath;
  final String name;
  final double rating;
  final int reviewCount;
  final String price;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const ProductCart({
    super.key,
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.4,
            height: width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: GColor.whiteGray,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        width: width * 0.12,
                        height: width * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: GColor.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Image.asset(
                                plus,
                                width: width * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: ResponsiveTextStyles.productTitle(context),
          ),
          Row(
            children: [
              Image.asset(
                star,
                width: width * 0.05,
              ),
              const SizedBox(width: 10),
              Text(
                "$rating ($reviewCount)",
                style: ResponsiveTextStyles.productRate(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            price,
            style: ResponsiveTextStyles.productRate(context),
          ),
        ],
      ),
    );
  }
}
