import 'package:caretag/Modules/records_module/model/medicine_model.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineContainerTile extends StatelessWidget {
  final Medications medications;
  const MedicineContainerTile({super.key, required this.medications});

  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xff334155);
    const Color greyColor = Color(0xff64748B);
    const Color boderColor = Color(0xffE2E8F0);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 10.w, right: 10.w),
      child: Stack(
        children: [
          Container(
            height: 112.h,
            width: 370.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              color: Color(0xff3B82F6),
            ),
          ),
          Positioned(
            left: 8,
            child: Container(
              height: 112.h,
              width: 365.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w, top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medications.name!,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: AppColor.darkishBlueTextColor,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              medications.dosage!,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColor.greyTextColor,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0.w),
                          child: Container(
                            width: 60.w,
                            height: 23.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffDBEAFE),
                            ),
                            child: Center(
                              child: Text(
                                medications.duration!,
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1D4ED8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.25.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: Row(
                      children: [
                        Icon(Icons.history),
                        SizedBox(width: 6.w),
                        Text(
                          "${medications.morning}-${medications.afternoon}-${medications.night}",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: textColor,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          width: 1.w,
                          height: 20.h,
                          decoration: BoxDecoration(color: boderColor),
                        ),
                        SizedBox(width: 16.w),
                        Icon(Icons.restaurant, color: greyColor),
                        SizedBox(width: 6.w),
                        Text(
                          medications.mealTiming!,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,

                            color: greyColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
