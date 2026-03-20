import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceDetailTitleTile extends StatelessWidget {
  final String hosptialName;
  final String address;
  const InvoiceDetailTitleTile({
    super.key,
    required this.hosptialName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.lightBlueSmallContainerColor,
            ),
            child: Center(
              child: SvgPicture.asset('assets/images/home/med.svg'),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hosptialName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: AppColor.darkishBlueTextColor,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: 160.w,
                child: Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyTextColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),

              SizedBox(
                width: 160.w,
                child: Text(
                  "GST: 29AABCU9603R1ZJ",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyTextColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15.w),
          Container(
            width: 65.85.w,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99999.r),
              color: AppColor.lightGreenSmallConatinerColor,
            ),
            child: Row(
              children: [
                SizedBox(width: 4.w),
                Icon(Icons.verified_outlined, color: AppColor.greenTextColor),
                SizedBox(width: 4.w),
                Text(
                  "PAID",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                    color: AppColor.greenTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
