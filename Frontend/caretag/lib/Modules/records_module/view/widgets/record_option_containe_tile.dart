import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordOptionContaineTile extends StatelessWidget {
  final Color containerColor;
  final String imagePath;
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double scale;

  const RecordOptionContaineTile({
    super.key,
    required this.containerColor,
    required this.imagePath,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color(0xff4B5563);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor,
            ),
            child: Center(
              child: Transform.scale(
                scale: scale,
                child: SvgPicture.asset(
                  imagePath,
                  width: 48.w,
                  height: 48.h,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          textAlign: TextAlign.center,
          title,
          style: GoogleFonts.poppins(
            fontWeight: fontWeight ?? FontWeight.w500,
            color: textColor ?? defaultTextColor,
            fontSize: fontSize ?? 10.sp,
          ),
        ),
      ],
    );
  }
}
