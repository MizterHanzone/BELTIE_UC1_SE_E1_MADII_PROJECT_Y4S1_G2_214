import 'package:flutter/material.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool isIconPrefix;
  final Color iconColor;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    this.controller,
    this.onChanged,
    this.isIconPrefix = false,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: OneHubColor.blackGrey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: isIconPrefix ? Icon(icon, color: iconColor) : null,
          suffixIcon: isIconPrefix ? null : Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
