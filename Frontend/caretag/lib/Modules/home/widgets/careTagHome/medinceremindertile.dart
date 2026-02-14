import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Medinceremindertile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color bodercolor = Color.fromRGBO(0, 0, 0, 0.7);
    Color conBGColor = Color(0xffEFF6FF);
    Color conBorderColor = Color.fromRGBO(105, 162, 241, 0.3);
    Color textColor = Color(0xff0078EC);
    Color con2BGColor = Color.fromRGBO(119, 119, 119, 0.1);

    return Container(
      height: 119,
      width: 358,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bodercolor, width: 0.2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Medication Tracker",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Container(
                  width: 58,
                  height: 17,
                  decoration: BoxDecoration(
                    color: conBGColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: conBorderColor, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Today",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 323,
            height: 48,
            decoration: BoxDecoration(
              color: con2BGColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 33,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(52, 110, 227, 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/images/home/med.svg"),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "Amoxicillin 500 mg",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "After lunch . 1 Tablet",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "Next dose",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    Container(
                      width: 63,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "02:45:02",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
