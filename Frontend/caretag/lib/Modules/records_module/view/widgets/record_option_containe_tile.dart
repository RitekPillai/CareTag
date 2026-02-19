import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordOptionContaineTile extends StatelessWidget {
  final Color containerColor;
  final String imagePath;
  final String title;
  const RecordOptionContaineTile({
    super.key,
    required this.containerColor,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xff4B5563);
    return Column(
      children: [
        Container(
          height: 56.h,
          width: 56.w,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: containerColor,
          ),
          child: Center(child: SvgPicture.asset(imagePath)),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: textColor,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
