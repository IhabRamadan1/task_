import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  primaryColorDark: Colors.white,
  primaryColorLight: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
);