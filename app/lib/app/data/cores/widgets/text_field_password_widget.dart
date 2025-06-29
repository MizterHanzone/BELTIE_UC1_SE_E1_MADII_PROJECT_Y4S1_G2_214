import 'package:app/app/data/cores/path_assets/path_color.dart';
import 'package:flutter/material.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const TextFieldPasswordWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  State<TextFieldPasswordWidget> createState() => _TextFieldPasswordWidget();
}

class _TextFieldPasswordWidget extends State<TextFieldPasswordWidget> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: OneHubColor.blackGrey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}
