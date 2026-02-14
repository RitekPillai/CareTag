import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CaretagHomepageHelpers {
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

  Widget adTile() {
    return Container(
      width: 350,
      height: 183,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/home/doctor.png"),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 3),
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
      ),
    );
  }
}
