import 'package:flutter/material.dart';
import 'package:one_hub_collection_app/core/theme/color.dart';

class TextFieldEmailWidget extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final IconData icon;
  final Color iconColor;

  const TextFieldEmailWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Email',
    this.icon = Icons.email,
    this.iconColor = Colors.grey,
  });

  @override
  State<TextFieldEmailWidget> createState() => _TextFieldEmailWidgetState();
}

class _TextFieldEmailWidgetState extends State<TextFieldEmailWidget> {
  String? errorText;

  void _validate(String value) {
    const pattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    setState(() {
      errorText = value.isEmpty
          ? 'Email is required'
          : (!regex.hasMatch(value) ? 'Enter a valid email' : null);
    });
    if (widget.onChanged != null) widget.onChanged!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: OneHubColor.blackGrey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            onChanged: _validate,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              suffixIcon: Icon(widget.icon, color: widget.iconColor),
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }
}
