import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Caretagcard extends StatelessWidget {
  const Caretagcard({super.key});

  @override
  Widget build(Object context) {
    return Container(
      width: 350,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0, color: Color.fromRGBO(0, 0, 0, 0.2)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      filterQuality: FilterQuality.high,
                      image: AssetImage("assets/images/home/card.png"),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff0063F7), Color(0xff3B639D)],
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "CareTag ID",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Steve harrington",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                Container(
                  width: 70,
                  height: 19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffDCFCE7),
                    border: Border.all(width: 1, color: Color(0xffBDF8D1)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0, right: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/home/verify.svg",
                          height: 10,
                          width: 10,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Verified",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFEF2F2),

                    border: Border.all(color: Color(0xffFFEAE9)),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "O+ve Blood",
                    style: GoogleFonts.poppins(
                      color: Color(0xffDC0000),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 317,
            child: Divider(color: Color.fromRGBO(0, 0, 0, 0.2), thickness: 0.9),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "READY TO SCAN",
                  style: GoogleFonts.poppins(
                    color: Color(0xff919395),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(150, 40)),
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      SvgPicture.asset("assets/images/home/scan.svg"),
                      const SizedBox(width: 5),
                      Text(
                        "Quick Scan",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
