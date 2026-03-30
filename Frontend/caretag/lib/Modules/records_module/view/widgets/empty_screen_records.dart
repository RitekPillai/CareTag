import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyRecordsWidget extends StatelessWidget {
  final String categoryName;
  final VoidCallback onAddRecord;

  const EmptyRecordsWidget({
    Key? key,
    required this.categoryName,
    required this.onAddRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF3B82F6);
    const Color darkText = Color(0xFF111827);
    const Color greyText = Color(0xFF6B7280);
    const Color lightBlueIcon = Color(0xFFBFDBFE);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 40.h),

            Icon(Icons.plagiarism_outlined, size: 110.sp, color: lightBlueIcon),

            SizedBox(height: 24.h),

            Text(
              'No Records Found',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),

            SizedBox(height: 12.h),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: greyText,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text: "You haven't added any diagnostic\nreports to the ",
                  ),
                  TextSpan(
                    text: categoryName,
                    style: GoogleFonts.inter(
                      color: primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: " category yet."),
                ],
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
