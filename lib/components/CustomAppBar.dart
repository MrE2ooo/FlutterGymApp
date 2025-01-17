import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor, // Update with your primary color
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.customWhite, 
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true, // Center the title
      elevation: 4, // Shadow effect
      automaticallyImplyLeading: false, // Remove the back arrow
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Default height for AppBar
}
