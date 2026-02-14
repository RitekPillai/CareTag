import 'package:caretag/Modules/home/widgets/careTagHome/barchart.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/currentdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StepcountCard extends StatelessWidget {
  const StepcountCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Color.fromRGBO(250, 164, 128, 0.05);
    Color boderColor = Color.fromRGBO(250, 164, 128, 0.6);
    Color containerColor = Color(0xffFFEDD5);
    Color greenColor = Color(0xff009E2D);
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        color: bgColor,
        border: Border.all(color: boderColor, width: 0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    color: containerColor,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/images/home/step.svg",
                        height: 18,
                        width: 17.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 54,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(0xffD7FEE3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_upward, color: greenColor, size: 18),
                      Text(
                        "12%",
                        style: GoogleFonts.poppins(
                          color: greenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "6,200",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Steps Taken",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 120, child: BarGraphTile()),

          Center(
            child: Container(
              width: 94,
              height: 14,
              decoration: BoxDecoration(
                color: Color(0xffFEEBDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                textAlign: TextAlign.center,
                getCurrentDate(DateTime.now()),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
