import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart'; // GColor

class TextBoxNormal extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextBoxNormal({
    super.key,
    required this.controller,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: ResponsiveTextStyles.authValueTextBox(context),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: ResponsiveTextStyles.labelTextBox(context),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GColor.whiteGray,
            width: 2,
          ),
        ),
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.only(top: 16),
      ),
    );
  }
}
