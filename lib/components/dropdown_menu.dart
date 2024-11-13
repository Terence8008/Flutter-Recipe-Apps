import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> positions;
  final String? selectedPosition;
  final ValueChanged<String?> onChanged;

  const MyDropdownMenu({
    super.key,
    required this.positions,
    this.selectedPosition,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedPosition,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
      ),
      hint: const Text('Position'),
      items: positions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
