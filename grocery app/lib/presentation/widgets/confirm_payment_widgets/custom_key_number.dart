import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

class CustomKeyNumber extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onDigitPressed;
  final VoidCallback onBackspace;

  const CustomKeyNumber({
    super.key,
    required this.controller,
    required this.onDigitPressed,
    required this.onBackspace,
  });

  Widget buildKey(String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GColor.white
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GColor.whiteGray,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.0, // wider and shorter
          children: [
            for (var i = 1; i <= 9; i++)
              buildKey('$i', onTap: () => onDigitPressed('$i')),
            buildKey('.', onTap: onBackspace),
            buildKey('0', onTap: () => onDigitPressed('0')),
            buildKey('x', onTap: onBackspace),
          ],
        ),
      ),
    );
  }
}
