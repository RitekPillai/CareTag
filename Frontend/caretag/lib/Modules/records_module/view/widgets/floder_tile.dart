import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FloderTile extends StatelessWidget {
  final String floderName;
  final int itemsLen;
  const FloderTile({
    super.key,
    required this.floderName,
    required this.itemsLen,
  });

  @override
  Widget build(BuildContext context) {
    const Color containerColor = Color(0xffF5F7F8);
    const Color innerContainerColor = Color.fromRGBO(13, 127, 242, 0.1);
    const Color textColor = Color(0xff0F172A);
    const Color discriptionColor = Color(0xff64748B);
    const Color iconColor = Color(0xff0D7FF2);
    return Container(
      width: 165.w,
      height: 120.03.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: containerColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 39.97.w,
              height: 36.03.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: innerContainerColor,
              ),
              child: Center(child: Icon(Icons.folder, color: iconColor)),
            ),
            SizedBox(height: 12.h),
            Text(
              floderName,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,

                color: textColor,
              ),
            ),

            Text(
              "$itemsLen items",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,

                color: discriptionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
