import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih_scanner/Utility/utils.dart';

class MyAppTheme {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      ),
      primarySwatch: AppUtility.createMaterialColor(BluishColor),
      cardColor: Colors.blueGrey.shade50,
      fontFamily: GoogleFonts.poppins().fontFamily);

  static ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
      cardColor: Colors.blueGrey.shade50,
      fontFamily: GoogleFonts.poppins().fontFamily);

  static ButtonStyle getAppButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
        elevation: 8,
        primary: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20));
  }

  //Colors
  static const Color CreamColor = Color(0xfff5f5f5);
  static const Color BluishColor = Color(0xff403b58);
  static const Color pinkShade = Color(0xffEF5F5F);
  static const Color cyanShade = Color(0xff1F8FA2);
  static const Color darkestBlue = Color(0xff1D293A);
  static const Color lightGreen = Color(0xff32a869);
}