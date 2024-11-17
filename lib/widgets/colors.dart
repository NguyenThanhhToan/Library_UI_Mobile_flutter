// lib/utils/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Gradient homeBackground = LinearGradient(
    colors: [
      Color(0xFFFFB6C1), // Màu hồng nhạt
      Color(0xFFFFE4B5), // Màu cam nhạt
      Color(0xFFFFFFFF), // Màu trắng
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color primaryColor = Color(0xFFAFEEEE);
  static const Color iconHighlight = Colors.grey;
  static const Color iconDefault = Colors.white;
}
