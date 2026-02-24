import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Acceptpage extends StatelessWidget {
  final String docName;
  final String hospitalName;
  const Acceptpage({
    super.key,
    required this.docName,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    const Color shawdowColor = Color.fromRGBO(16, 185, 129, 0.4);
    const Color imageColor = Color(0xff10B981);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 112.h),
          Center(
            child: Container(
              width: 128.w,
              height: 128.h,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    spreadRadius: -5,
                    color: shawdowColor,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/home/dialog/shiled.svg",
                  width: 53.33.w,
                  height: 66.67.h,
                  color: imageColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          Text(
            "Access Granted",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              color: AppColor.darkishBlueTextColor,
            ),
          ),
          SizedBox(height: 14.75.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: docName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColor.darkishBlueTextColor,
                ),
                children: [
                  TextSpan(
                    text:
                        " from $hospitalName now has access to your medical records for your consultation",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColor.greyTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 300.h),
          customElevatedButton(
            56.h,
            342.w,
            "Back to Home",
            16.sp,
            FontWeight.w700,
            () {
              Navigator.pop(context);
            },
            12.r,
          ),
        ],
      ),
    );
  }
}
