import 'package:caretag/Modules/doctor_details/model/get_doctor_model.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MydoctorContainerTile extends StatelessWidget {
  final GetDoctorModel getDoctorModel;
  const MydoctorContainerTile({super.key, required this.getDoctorModel});

  @override
  Widget build(BuildContext context) {
    const Color conatinerBgColor = Color(0xffF6F7F8);

    const Color darkTextColor = Color(0xff111418);
    const Color greyTextColor = Color(0xff6175789);
    const Color lightblueBackgroundColor = Color.fromRGBO(19, 127, 236, 0.1);
    const Color lightblueTextColor = Color(0xff137FEC);
    return Container(
      width: 160.w,
      height: 208.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: conatinerBgColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.getShadowColor(0.05),
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: CircleAvatar(
              backgroundImage: NetworkImage(getDoctorModel.imgUrl!),
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            getDoctorModel.docName,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: darkTextColor,
            ),
          ),

          SizedBox(height: 4.h),
          Text(
            getDoctorModel.speclization,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: greyTextColor,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 128.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: lightblueBackgroundColor,
              borderRadius: BorderRadius.circular(9999.r),
            ),
            child: Center(
              child: Text(
                "Book Again",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  color: lightblueTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
