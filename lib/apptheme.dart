import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  Color primary = Color(0xFF005792);
  Color grey = Colors.grey.shade400;

  TextTheme textTheme = TextTheme();

  TextStyle hintstyle = TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade400,
  );
}
