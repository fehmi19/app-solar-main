import 'package:flutter/material.dart';
import '/home_screen.dart';
import '/app_theme.dart';

void main() {
  runApp(SolarSystemApp());
}

class SolarSystemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'النظام الشمسي',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
