import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primary = const Color(0xFF009595);

abstract class AppTextStyle {
  static var bigTitle = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0.5,
  );

  static var title = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static var normal = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.5,
  );

  static var small = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.3,
  );
}

abstract class AppShadow {
  static var card = const BoxShadow(
    color: Color(0x00000014),
    blurRadius: 20,
    spreadRadius: 3,
    offset: Offset(0, 3),
  );
}
