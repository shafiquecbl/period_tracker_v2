import 'package:flutter/material.dart';
import 'package:food_delivery/utils/style.dart';

ThemeData dark({Color color = const Color(0xFFE66D81)}) => ThemeData(
      useMaterial3: true,
      fontFamily: 'poppins',
      primaryColor: color,
      primaryColorDark: const Color(0xFF1ED7AA),
      secondaryHeaderColor: const Color(0xFF009f67),
      disabledColor: const Color(0xffa2a7ad),
      scaffoldBackgroundColor: const Color(0xFF1A1D1F),
      brightness: Brightness.dark,
      hintColor: const Color(0xFFbebebe),
      cardColor: const Color(0xFF272B30),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.dark(primary: color, secondary: color).copyWith(
          background: const Color(0xFF1A1D1F),
          error: const Color(0xFFdd3135),
          outline: const Color(0xFF2C2C2C)),
      textTheme: const TextTheme(
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
        color: Color(0xFF1A1D1F),
        iconTheme: IconThemeData(color: Color(0xFFbebebe)),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: fontWeightSemiBold,
            fontFamily: 'poppins'),
      ),
    );
