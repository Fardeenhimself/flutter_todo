import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kDarkThemeColor = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 94, 147, 108),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: kDarkThemeColor,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kDarkThemeColor.primaryContainer,
    foregroundColor: kDarkThemeColor.onPrimaryContainer,
    centerTitle: true,
    elevation: 2,
    titleSpacing: 1.5,
  ),

  cardTheme: CardThemeData().copyWith(
    color: kDarkThemeColor.primaryContainer,
    shadowColor: kDarkThemeColor.secondaryContainer,
    elevation: 2,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(20),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
    backgroundColor: kDarkThemeColor.primaryContainer,
    elevation: 2,
  ),

  textTheme: GoogleFonts.interTextTheme(),
);
