import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customDivider(String title, double width) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: width,
        child: Divider(color: Colors.black, thickness: 0.5),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      SizedBox(
        width: width,
        child: Divider(color: Colors.black, thickness: 0.5),
      ),
    ],
  );
}
