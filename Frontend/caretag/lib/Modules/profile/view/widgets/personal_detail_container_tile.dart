import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileEditTile extends StatelessWidget {
  final String header;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  const CustomProfileEditTile(
    this.textInputType, {
    super.key,
    required this.header,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
          child: Text(
            header,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Color(0xFF6B7280),
            ),
          ),
        ),

        SizedBox(width: 5.5.w),
        SizedBox(
          width: 318.w,
          child: TextField(
            keyboardType: textInputType,

            controller: controller,
            decoration: InputDecoration(
              fillColor: Color(0xffF9FAFB),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
