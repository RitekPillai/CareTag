import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Caretagpage extends StatelessWidget {
  const Caretagpage({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Color(0xff0063F7);
    return Column(
      children: [
        const SizedBox(height: 15),
        customSearchBar(),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "CareTag Card",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View Card",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 174,
          width: 349,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: AlignmentGeometry.topCenter,
              colors: AppColor.gradientButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}
