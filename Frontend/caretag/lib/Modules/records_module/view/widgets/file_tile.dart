import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FileTile extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String fileDate;
  final String fileType;
  final bool isSelected;
  final void Function(bool?)? onSelected;
  const FileTile({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.fileDate,
    required this.fileType,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const Color boderColor = Color(0xffF1F5F9);
    const Color shawdowColor = Color.fromRGBO(0, 0, 0, 0.05);
    const Color lightRed = Color(0xffFEF2F2);
    const Color lightBlue = Color(0xffEFF6FF);
    const Color textColor = Color(0xff0F172A);
    const Color discriptionColor = Color(0xff64748B);
    const Color dotColor = Color(0xffCBD5E1);
    const Color selectedTileColor = Color.fromRGBO(13, 127, 242, 0.05);
    const Color selectedBoderColor = Color.fromRGBO(13, 127, 242, 0.2);
    bool isPdf = fileType == "PDF";

    return Container(
      width: 342.w,
      height: 74.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? selectedTileColor : Colors.white,
        border: Border.all(
          width: 1,
          color: isSelected ? selectedBoderColor : boderColor,
        ),
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
        children: [
          SizedBox(width: 12.w),

          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPdf ? lightRed : lightBlue,
            ),
            child: Center(
              child: isPdf
                  ? SvgPicture.asset("assets/images/records/pdf.svg")
                  : SvgPicture.asset("assets/images/records/docs.svg"),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: textColor,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: fileSize,

                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,

                    color: discriptionColor,
                  ),

                  children: [
                    TextSpan(
                      text: "•",
                      style: GoogleFonts.poppins(color: dotColor),
                      children: [
                        TextSpan(
                          text: fileDate,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,

                            color: discriptionColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          isSelected
              ? SvgPicture.asset("assets/images/records/Input(1).svg")
              : SvgPicture.asset("assets/images/records/Input.svg"),
        ],
      ),
    );
  }
}
