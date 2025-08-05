import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: GColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: GColor.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 24,
          elevation: 1,
          style: TextStyle(
            color: GColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          isExpanded: true,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedValue = value;
              });
              widget.onChanged(value);
            }
          },
          items: widget.items.map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
