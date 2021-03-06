import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppStyle.scaffoldBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, opacity: 0.7, size: 24),
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppStyle.textFieldFillColor,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
  ),
  cardColor: AppStyle.surveyListItemBackgroundColor,
);

ThemeData darkTheme = ThemeData.dark().copyWith();
