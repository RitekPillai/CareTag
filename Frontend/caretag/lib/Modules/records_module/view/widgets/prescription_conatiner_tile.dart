import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescriptionConatinerTile extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String hosptialName;

  ///TODO:ADD primary specification
  const PrescriptionConatinerTile({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.hosptialName,
  });

  @override
  Widget build(BuildContext context) {
    const Color boxShawDowColor = Color.fromRGBO(0, 0, 0, 0.1);
    const Color containerColor = Color(0xffF8FAFC);

    return Container(
      width: 358.w,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
            color: boxShawDowColor,
          ),
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
            color: boxShawDowColor,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 21.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    SizedBox(width: 64.w, height: 64.h, child: CircleAvatar()),
                    Positioned(
                      top: 40,
                      left: 40,
                      child: SvgPicture.asset(
                        "assets/images/records/prescription/tick.svg",
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. $doctorName",
                        style: GoogleFonts.inder(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          color: AppColor.darkishBlueTextColor,
                        ),
                      ),
                      Text(
                        "$specialization • MBBS, MD",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColor.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: containerColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/records/prescription/plus].svg",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.h),

            Divider(color: AppColor.greyTextColor.withAlpha(100)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hosptialName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Color(0xff334155),
                      ),
                    ),
                    Text(
                      "Building 4, Cyber City, Gurugram",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Color(0xff64748B),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View Profile >",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: Color(0xff137FEC),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
