import 'dart:math';

import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Steve Harrington",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        "Blood Type O+ve",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  SvgPicture.asset(
                    "assets/images/home/shiled.svg",
                    width: 65,
                    height: 68,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 291,
                  height: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Tap to show full emergency info",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                adTile(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quick Services",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff0063F7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                servicesList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget adTile() {
  return Container(
    width: 350,
    height: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/home/doctor.png"),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: Container(
            width: 88,
            height: 22,
            decoration: BoxDecoration(
              color: Color(0xffFF4D8C),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "EXCLUSIVE",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: Text(
            "Consult Top\nDoctors Online",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Video consultations in 15 mins",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, bottom: 8),
          child: ElevatedButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(115, 31)),

              backgroundColor: WidgetStatePropertyAll(Color(0xff0063F7)),
            ),
            onPressed: () {},
            child: Text(
              "Book Now",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget servicesList() {
  return GridView(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 0.85,
    ),
    children: [
      serviceTitle(
        "assets/images/home/appo.svg",
        "Book\nAppointment",
        Color(0xffEFF6FF),
        Color(0xffDEEAFB),
      ),
      serviceTitle(
        "assets/images/home/news.svg",
        "Read\nDaily News",
        Color(0xffECFDF5),
        Color(0xffD5FBE8),
      ),
      serviceTitle(
        "assets/images/home/lab.svg",
        "Lab\nTests",
        Color(0xffFFFBEB),
        Color(0xffFDF3C8),
      ),
      serviceTitle(
        "assets/images/home/qr.svg",
        "CareTag\nScan",
        Color(0xffECFEFF),
        Color(0xffCEF9FD),
      ),
      serviceTitle(
        "assets/images/home/rec.svg",
        "Health\nRecords",
        Color(0xffEEF2FF),
        Color(0xffE6EAFA),
      ),
      serviceTitle(
        "assets/images/home/doc.svg",
        "My\nDoctors",
        Color.fromRGBO(69, 215, 249, 0.2),
        Color.fromRGBO(69, 215, 249, 0.5),
      ),
      serviceTitle(
        "assets/images/home/in.svg",
        "Health\nInsurance",
        Color.fromRGBO(153, 23, 88, 0.2),
        Color.fromRGBO(153, 23, 88, 0.5),
      ),
      serviceTitle(
        "assets/images/home/sos.svg",
        "SOS\nHelp",
        Color.fromRGBO(254, 242, 242, 1),
        Color.fromRGBO(254, 228, 228, 1),
      ),
    ],
  );
}

Widget serviceTitle(
  String imagePath,
  String value,
  Color color,
  Color boderColor,
) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: boderColor, width: 1),
        ),
        child: Center(child: SvgPicture.asset(imagePath)),
      ),
      Text(
        textAlign: TextAlign.center,
        value,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    ],
  );
}
