import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

class TextBoxPassword extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const TextBoxPassword({
    Key? key,
    required this.controller,
    this.label = 'Password',
  }) : super(key: key);

  @override
  State<TextBoxPassword> createState() => _TextBoxPasswordState();
}

class _TextBoxPasswordState extends State<TextBoxPassword> {
  bool _obscure = true;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: _validatePassword,
      style: ResponsiveTextStyles.authValueTextBox(context),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: ResponsiveTextStyles.labelTextBox(context),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() => _obscure = !_obscure);
          },
        ),
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
