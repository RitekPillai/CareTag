import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorProfileTile extends StatelessWidget {
  final String path;
  final String title;
  final String discription;
  const DoctorProfileTile({
    super.key,
    required this.path,
    required this.title,
    required this.discription,
  });

  @override
  Widget build(BuildContext context) {
    const Color conatinerBgColor = Color(0xffF8FAFC);
    const Color containerBoderColor = Color(0xffF1F5F9);
    const String imagePath = "assets/images/mycare/mydoctor/";
    return Container(
      width: 111.33.w,
      height: 111.h,
      decoration: BoxDecoration(
        color: conatinerBgColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(width: 1, color: containerBoderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          SvgPicture.asset(imagePath + path),
          SizedBox(height: 8.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.darkishBlueTextColor,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            discription,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.greyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
