import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class AppTheme {
  const AppTheme._();

  static AppTheme get instance => const AppTheme._();

  ThemeData getTheme() {
    var baseFont = GoogleFonts.montserratAlternates();
    return ThemeData(
      //* General */
      useMaterial3: true,
      colorSchemeSeed: CyttekColor.primaryColor,

      ///* Texts
      textTheme: TextTheme(
        titleLarge: baseFont.copyWith(
          fontSize: size40,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: baseFont.copyWith(
          fontSize: size30,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: baseFont.copyWith(fontSize: size20),
        bodyMedium: baseFont.copyWith(fontSize: size16),
      ),

      ///* Scaffold Background Color
      scaffoldBackgroundColor: CyttekColor.scaffoldBackgroundColor,
    );
  }
}
