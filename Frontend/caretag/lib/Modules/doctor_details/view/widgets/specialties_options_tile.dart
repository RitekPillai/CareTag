import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialtiesOptionsTile extends StatelessWidget {
  final Color containerColor;
  final String title;
  final String imagePath;
  const SpecialtiesOptionsTile({
    super.key,
    required this.containerColor,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final String image = "assets/images/mycare/mydoctor";
    final Color textColor = Color(0xff617589);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(16.r),
            border: BoxBorder.all(color: Colors.transparent, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColor.getShadowColor(0.05),
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Center(child: SvgPicture.asset("$image$imagePath")),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
