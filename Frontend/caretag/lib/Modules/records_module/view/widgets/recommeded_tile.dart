import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommededTile extends StatelessWidget {
  final String title;

  final String date;
  final String buttonText;
  const RecommededTile({
    super.key,

    required this.title,

    required this.date,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    Color boderColor = Color(0xffF3F4F6);
    Color shadowColor = Color.fromRGBO(0, 0, 0, 0.05);
    Color blueContianerColor = Color(0xffEEF2FF);
    Color orangeContainerColor = Color(0xffF0FDFA);
    Color textFontColor = Color(0xff4338CA);
    Color titleTextColor = Color(0xff1F2937);
    Color dateTextColor = Color(0xff6B7280);
    Color buttonTextColor = Color(0xff0D7FF2);
    return Container(
      width: 200.w,
      height: 145.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: Colors.white,
        border: BoxBorder.all(width: 1, color: boderColor),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: shadowColor,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == "Renew Insurance"
              ? Padding(
                  padding: EdgeInsets.only(left: 17.w, top: 17.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: blueContianerColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/images/records/shild.svg",
                          ),
                        ),
                      ),
                      Container(
                        width: 49.8.w,
                        height: 19.h,
                        decoration: BoxDecoration(
                          color: blueContianerColor,
                          borderRadius: BorderRadius.circular(60.r),
                        ),
                        child: Center(
                          child: Text(
                            "Critical",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: textFontColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 17.w, top: 17.h),
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: orangeContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/records/calendar.svg",
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 17.w, bottom: 4.h),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: titleTextColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 17.w, bottom: 12.h),
            child: Text(
              date,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: dateTextColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 17.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: buttonTextColor,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward,
                  color: buttonTextColor,
                  size: 20,
                  weight: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
