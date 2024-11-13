import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Colors.grey, // Buttons and icons color
    secondary: Colors.grey, // Accent for interactive elements
    onPrimary: Colors.white, // Text on primary elements
    onSurface: Colors.black, // Text on surface elements
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black, // Readable text on light background
        displayColor: Colors.black,
      ),
);
