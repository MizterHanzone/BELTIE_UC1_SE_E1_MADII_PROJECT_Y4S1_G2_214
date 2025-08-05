import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';

class SeeAllRow extends StatelessWidget {
  final String title;

  const SeeAllRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Text(
        title,
        style: ResponsiveTextStyles.seeAllLabel(context)
      ),
    );
  }
}
