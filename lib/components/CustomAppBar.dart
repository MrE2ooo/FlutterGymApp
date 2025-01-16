import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF4dadf7), // Update with your primary color
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white60, // Dark gray for better contrast
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true, // Center the title
      elevation: 4, // Shadow effect
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Default height for AppBar
}
