// custom_chip.dart
import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';

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
        color: AppColors.customChipColor, // Background color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.customWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
