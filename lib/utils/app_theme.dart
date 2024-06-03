import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    fontFamily: "AlegreyaSans",
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 38,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(color: Colors.black, fontSize: 15),
      displayMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blue),
      headlineSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
    ),
  );
}
