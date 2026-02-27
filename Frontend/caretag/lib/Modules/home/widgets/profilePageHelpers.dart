import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

final String path = "assets/images/profilePage";

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // 1. Draw the top part of the rectangle
    // We leave space at the bottom for the circle
    double radius = size.width / 2;
    path.lineTo(0, size.height - radius);

    // 2. Define the "Rect" that the circle lives in
    // This creates an invisible box at the bottom where the curve sits
    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height - radius),
      radius: radius,
    );

    // 3. Draw an arc from 0 degrees (left) to 180 degrees (right)
    // In Flutter, 0 radians is at the "3 o'clock" position,
    // so we start at pi (9 o'clock) and move pi radians (half circle).
    path.arcTo(rect, 3.14159, -3.14159, false);

    // 4. Close the path back to the top-right and then top-left
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Widget infoTitle(
  String imagePath,
  String value,
  String descriptiond, [
  double size = 180,
]) {
  return Container(
    width: size,
    height: 87,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),

      boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 50, child: SvgPicture.asset(imagePath, height: 65)),
          const SizedBox(width: 10),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                descriptiond,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xff939BA6),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget accountSettingSection() {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
          child: Text(
            "Account Settings",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        profileRowTile("assets/images/profilePage/user.svg", "Edit profile"),
        profileRowTile("assets/images/profilePage/card.svg", "Payment methods"),
        profileRowTile("$path/settings.svg", "App settings"),
        profileRowTile("$path/bell.svg", "Notification Preference"),
        profileRowTile("$path/lock.svg", "Security & Login"),
      ],
    ),
  );
}

Widget earningUsageSection() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
          child: Text(
            "Earning / Usage Section",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        profileRowTile("$path/dashboard.svg", "My DashBoard"),
        profileRowTile("$path/lock.svg", "Subscriptions"),
        profileRowTile("$path/history.svg", "Transcation History"),
      ],
    ),
  );
}

Widget supportHelpSection() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
          child: Text(
            "Support & Help",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        profileRowTile("$path/help.svg", "Help Center"),
        profileRowTile("$path/call.svg", "Contact Support"),
        profileRowTile("$path/report.svg", "Report a Problem"),
      ],
    ),
  );
}

Widget appLeagalSection() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
          child: Text(
            "App & Legal",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        profileRowTile("$path/app.svg", "App Preference"),
        profileRowTile("$path/terms.svg", "Terms & Conditions Support"),
        profileRowTile("$path/privacy.svg", "privacy policy"),
        profileRowTile("$path/laboutApp.svg", "About App"),
      ],
    ),
  );
}

Widget profileRowTile(String Imagepath, String value) {
  Color textColor = Color(0xff415762);
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(Imagepath, width: 32, height: 35),
            const SizedBox(width: 5),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: textColor,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/profilePage/arrow.svg",
                width: 30,
                height: 30,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
