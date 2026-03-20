import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceDetailBillingTile extends StatelessWidget {
  final String paitentName;
  final String time;
  final double tax;
  final double fee;
  final double totalAmt;

  const InvoiceDetailBillingTile({
    super.key,
    required this.paitentName,
    required this.time,
    required this.tax,
    required this.fee,
    required this.totalAmt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              fromToBilling("Billed To", paitentName),
              fromToBilling("Date", time),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        SizedBox(
          width: 308,
          child: Divider(color: AppColor.whiteCreamColor, thickness: 1.5),
        ),

        SizedBox(height: 24.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: prices("Consultation Fee", fee),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: prices("Taxes (0%)", tax),
        ),

        SizedBox(height: 24.h),
        SizedBox(
          width: 308,
          child: Divider(color: AppColor.whiteCreamColor, thickness: 1.5),
        ),

        SizedBox(height: 26.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: AppColor.darkishBlueTextColor,
                ),
              ),
              Text(
                "₹$totalAmt",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  color: AppColor.lightBlueTextColor2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget fromToBilling(String heading, String title) {
  const Color greyTextColor = Color(0xff94A3B8);
  return Column(
    crossAxisAlignment: heading == "Date"
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
    children: [
      Text(
        heading,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: greyTextColor,
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: AppColor.darkishBlueTextColor,
        ),
      ),
    ],
  );
}

Widget prices(String heading, double amount) {
  const Color greyTextColor = Color(0xff475569);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Consultation Fee",
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: greyTextColor,
        ),
      ),
      Text(
        "₹$amount",
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          color: AppColor.darkishBlueTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
