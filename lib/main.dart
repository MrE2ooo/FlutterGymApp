import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';
import 'package:gymapp/data/workout_data.dart';
import 'package:gymapp/pages/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
