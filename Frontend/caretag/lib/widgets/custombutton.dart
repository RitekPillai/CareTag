import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customElevatedButton(
  double height,
  double width,
  String title,
  double fontSize,
  FontWeight fontWeight,
  VoidCallback onPressed,
) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(33),
      gradient: LinearGradient(colors: AppColor.gradientButtonColor),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  );
}
