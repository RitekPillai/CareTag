import 'package:caretag/widgets/helpPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCaretagcardPage extends StatelessWidget {
  const ViewCaretagcardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_rounded, weight: 23),
        actions: [help()],
      ),
      body: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            "This digital ID links to your secure medical profile.",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
