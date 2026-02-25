import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class DocReportConatinerTile extends StatelessWidget {
  final String docName;
  final String hospitalName;
  const DocReportConatinerTile({
    super.key,
    required this.docName,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    const Color containerBorderColor = Color(0xffF1F5F9);
    const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.05);
    const Color smallContainerColor = Color(0xffEFF6FF);
    return Container(
      width: 358.w,
      height: 92.h,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 1,
            spreadRadius: 0,
            color: shadowColor,
          ),
        ],
        border: Border.all(color: containerBorderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: smallContainerColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/home/dialog/hospital.svg",
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FLAGGING REQUEST FROM",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColor.greyTextColor,
                ),
              ),
              Text.rich(
                textAlign: TextAlign.start,
                TextSpan(
                  text: "Dr. $docName • ",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),

                  children: [
                    TextSpan(
                      text: hospitalName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: AppColor.lightBlueTextColor2,
                      ),
                    ),
                    TextSpan(
                      text: "\n Hospital",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: AppColor.lightBlueTextColor2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
