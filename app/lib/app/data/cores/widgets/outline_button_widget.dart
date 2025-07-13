import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String text;
  final String imagePath; // local asset path or network URL
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final double imageSize;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isNetwork;

  const OutlineButtonWidget({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
    this.borderColor = Colors.black,
    this.textColor = Colors.black,
    this.imageSize = 24,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.isNetwork = false, // true if imagePath is a network URL
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = isNetwork
        ? Image.network(imagePath, width: imageSize, height: imageSize)
        : Image.asset(imagePath, width: imageSize, height: imageSize);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        backgroundColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          imageWidget,
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
