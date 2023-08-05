import 'package:flutter/material.dart';
import 'package:food_delivery/utils/style.dart';

ThemeData light({Color color = const Color(0xFFA72F53)}) => ThemeData(
      useMaterial3: true,
      fontFamily: 'poppins',
      primaryColor: color,
      primaryColorLight: const Color(0xfff5c5cd),
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: const Color(0xFFF6F6F6),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color).copyWith(
          background: const Color(0xFFFFFFFF),
          error: const Color(0xFFdd3135),
          outline: const Color(0xFFF4F4F4)),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        titleSpacing: 20,
        color: Color(0xFFFFFFFF),
        iconTheme: IconThemeData(color: Color(0xFF9F9F9F)),
        titleTextStyle: TextStyle(
            color: Color(0xFF000000),
            fontSize: 20,
            fontWeight: fontWeightSemiBold,
            fontFamily: 'poppins'),
      ),
    );
