import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagonsisContainerTile extends StatelessWidget {
  final String diagonsis;
  const DiagonsisContainerTile({super.key, required this.diagonsis});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color(0xffF1F5F9);
    const Color containerColor = Color(0xffEFF6FF);
    const Color textColor = Color(0xff334155);
    return Container(
      width: 358.w,
      height: 170.25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: Colors.white,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 22.h),
            child: Row(
              children: [
                SvgPicture.asset("assets/images/records/prescription/scop.svg"),
                SizedBox(width: 8.w),
                Text(
                  "Diagnosis / Symptoms",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: AppColor.darkishBlueTextColor,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 316.w,
            height: 92.25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              color: containerColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 12.0.w, top: 10.h),
              child: Text(
                diagonsis,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
