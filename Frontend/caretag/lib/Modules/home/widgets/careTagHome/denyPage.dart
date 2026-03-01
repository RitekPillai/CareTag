import 'package:caretag/Modules/home/widgets/careTagHome/upperSection_denyPage.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Denypage extends StatelessWidget {
  final String docName;
  final String hospitalName;
  const Denypage({
    super.key,
    required this.docName,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.08);
    const Color greyTextColor = Color(0xff475569);
    const Color lightGreyTextColor = Color(0xff94A3B8);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 144.h),
          UppersectionDenypage(),
          SizedBox(height: 40.5.h),
          Text(
            "Access Denied",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              color: AppColor.darkishBlueTextColor,
            ),
          ),
          SizedBox(height: 12.h),

          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: "You have restricted ",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.greyTextColor,
              ),
              children: [
                TextSpan(
                  text: "Dr. $docName",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColor.darkishBlueTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: " from \n",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColor.greyTextColor,
                      ),
                    ),
                    TextSpan(
                      text: "$hospitalName ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColor.darkishBlueTextColor,
                      ),
                    ),
                    TextSpan(
                      text: "from viewing your \nmedical records.",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColor.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          Container(
            width: 350.w,
            height: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  spreadRadius: -10,
                  offset: Offset(0, 10),
                  color: shadowColor,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 28.h),
                  child: SvgPicture.asset("assets/images/home/dialog/mark.svg"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 24),
                  child: Text(
                    "The doctor will not be able to access \nyour data during the consultation.You\ncan manually grant access at any time\nfrom your security settings.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: greyTextColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/home/dialog/time.svg"),
                SizedBox(width: 12.w),
                Text(
                  "This action has been recorded in your Security Logs.",
                  style: GoogleFonts.poppins(
                    color: lightGreyTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),

          customElevatedButton(
            56.h,
            342.w,
            "Back to Home",
            16,
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
