import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget help() {
  return Padding(
    padding: const EdgeInsets.only(top: 20, right: 20),
    child: Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Help?",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
