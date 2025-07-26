import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kLightThemeColor = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 147, 218, 151),
);

ThemeData lighTheme = ThemeData().copyWith(
  colorScheme: kLightThemeColor,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kLightThemeColor.primaryContainer,
    foregroundColor: kLightThemeColor.onPrimaryContainer,
    centerTitle: true,
    elevation: 2,
    titleSpacing: 1,
  ),

  cardTheme: CardThemeData().copyWith(
    color: kLightThemeColor.primaryContainer,
    shadowColor: kLightThemeColor.secondaryContainer,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(20),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
    backgroundColor: kLightThemeColor.primaryContainer,
    elevation: 2,
  ),

  textTheme: GoogleFonts.interTextTheme(),
);
