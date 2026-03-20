import 'dart:ui';

import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalNearbyTile extends StatelessWidget {
  const HospitalNearbyTile({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkishColor = Color(0xff111817);
    return Container(
      width: 256.w,
      height: 238.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: Color(0xffF3F4F6), width: 1),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: AppColor.getShadowColor(0.5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Container(
              width: double.infinity,
              height: 128.h,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/mycare/hosptial.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 50.85.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
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
                        children: [
                          Icon(
                            Icons.star_outline_sharp,
                            color: Color(0xffF59E0B),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "4.8",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: darkishColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///postition
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      width: 75.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColor.getShadowColor(0.6),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.navigation, color: Colors.white, size: 20),
                          SizedBox(width: 3.w),
                          Text(
                            "1.3 km",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "City General Hospital",
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Color(0xff111817),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Cardiology, Neurology, Emergency",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Color(0xff618986),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: 96.w,
                height: 24.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0xffF0FDF4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.done),
                    SizedBox(width: 2.17.w),
                    Text(
                      "Open 24/7",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xff16A34A),
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
