import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart'; // GColor

class TextBoxNumber extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  const TextBoxNumber({
    super.key,
    required this.controller,
    this.label = '',
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.emailAddress,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
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
