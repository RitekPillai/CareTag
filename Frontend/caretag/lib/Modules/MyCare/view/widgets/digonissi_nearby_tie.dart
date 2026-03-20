import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DigonissiNearbyTie extends StatelessWidget {
  const DigonissiNearbyTie({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 106.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        border: BoxBorder.all(color: AppColor.whiteCreamColor),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: AppColor.getShadowColor(0.05),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              width: 80.w,
              height: 80.h,
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuSjh7qca02uLPjdQAP--MzUR8qzIUUmB03w&s",
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            children: [
              SizedBox(height: 12.h),
              Text(
                "MediCare Diagnostics",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: AppColor.darkishColor,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Blood Test, MRI, X-Ray",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Color(0xff618986),
                ),
              ),
              SizedBox(height: 19.h),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 96.72.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                    border: Border.all(color: Color(0xffE5E7EB)),
                  ),
                  child: Center(
                    child: Text(
                      "View Details",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColor.darkishColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
