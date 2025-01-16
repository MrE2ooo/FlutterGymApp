// custom_chip.dart
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;

  const CustomChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Padding around the text
      decoration: BoxDecoration(
        color: const Color(0xFF70B4E4), // Background color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
