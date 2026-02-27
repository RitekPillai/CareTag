import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesContainerTile extends StatelessWidget {
  const NotesContainerTile({super.key});

  @override
  Widget build(BuildContext context) {
    const Color boderColor = Color(0xffF1F5F9);
    const Color shawdowColor = Color.fromRGBO(0, 0, 0, 0.05);
    return Container(
      width: 358.w,
      height: 194.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: Colors.white,
        border: Border.all(color: boderColor, width: 1),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: shawdowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0.w, top: 22.h),
            child: Row(
              children: [
                SvgPicture.asset("assets/images/records/prescription/blub.svg"),
                SizedBox(width: 8.w),
                Text(
                  "Notes",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: AppColor.darkishBlueTextColor,
                  ),
                ),
              ],
            ),
          ),

          Text(""),
        ],
      ),
    );
  }
}
