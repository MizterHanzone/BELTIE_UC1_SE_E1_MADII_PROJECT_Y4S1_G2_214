import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart'; // GColor

class TextBoxEmail extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextBoxEmail({
    Key? key,
    required this.controller,
    this.label = 'Email',
  }) : super(key: key);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: _validateEmail,
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
