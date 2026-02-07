import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customSearchBar() {
  Color borderColor = Color(0xff5EACFF);
  return SizedBox(
    height: 70,
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          hintText: "Search",
          helperStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.amber,
          ),

          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset("assets/images/home/search.svg"),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset("assets/images/home/settings.svg"),
          ),
        ),
      ),
    ),
  );
}
