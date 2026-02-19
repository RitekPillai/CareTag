import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FilesTile extends StatelessWidget {
  const FilesTile({super.key});

  @override
  Widget build(BuildContext context) {
    const Color boderColor = Color(0xffF3F4F6);
    const Color shawdowColor = Color.fromRGBO(0, 0, 0, 0.05);
    const Color containerColor = Color(0xffFEF2F2);
    const Color textColor = Color(0xff1F2937);
    const Color discriptionTextColor = Color(0xff6B7280);
    const Color verfiyContainerColor = Color(0xffDCFCE7);
    const Color textColor2 = Color(0xff15803D);
    const Color greyishColor = Color(0xff9CA3AF);

    return Container(
      width: 344.w,
      height: 66.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        border: BoxBorder.all(width: 1, color: boderColor),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: shawdowColor,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor,
            ),
            child: Center(
              child: SvgPicture.asset("assets/images/records/pdf.svg"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140.w,
                height: 20.h,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Blood Test Results asdasdasdssdfsdfa",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
              Text(
                "May 12, 2023 • 2.4 MB",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: discriptionTextColor,
                ),
              ),
            ],
          ),
          Container(
            width: 60.89.w,
            height: 23.h,
            decoration: BoxDecoration(
              color: verfiyContainerColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "VERIFIED",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: textColor2,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Icon(Icons.remove_red_eye, color: greyishColor),
        ],
      ),
    );
  }
}
