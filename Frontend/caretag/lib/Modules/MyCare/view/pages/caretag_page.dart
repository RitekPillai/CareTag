import 'package:caretag/Modules/card_registration/data/repos/paitent_repo.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CaretagPage extends StatelessWidget {
  const CaretagPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color containerShawodwColor = Color.fromRGBO(30, 58, 138, 0.2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19.w),
          child: Text(
            "CareTag Digital ID",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: AppColor.darkishBlueTextColor,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<PatientBloc, PatientBlocState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is Failed) {
              return Center(child: Text("Failed To Load the CaretagCard "));
            }
            if (state is ProfileRecordFetched) {
              final profileRecrd = state.profilemodel;
              return Padding(
                padding: EdgeInsets.only(left: 19.w),
                child: Stack(
                  children: [
                    Container(
                      width: 358.w,
                      height: 204.72.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 25),
                            blurRadius: 50,
                            spreadRadius: -12,
                            color: containerShawodwColor,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff137FEC),
                            Color(0xff0F60B6),
                            Color(0xff0A3D75),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40.h),
                            topPartCard(),
                            Text(
                              profileRecrd.fullName,
                              style: GoogleFonts.inter(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ID: ${profileRecrd.careTagId}",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Color.fromRGBO(255, 255, 255, 0.7),
                                  ),
                                ),
                                Container(
                                  width: 79.7.w,
                                  height: 26.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      99999.r,
                                    ),
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    border: BoxBorder.all(
                                      width: 1.w,
                                      color: Color.fromRGBO(255, 255, 255, 0.1),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${profileRecrd.bloodGroup} Blood ",
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: 358.w,
                      height: 204.72.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColor.getShadowColor(0.4),
                            AppColor.getShadowColor(0),
                          ],
                          stops: [0.0, 0.6],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(height: 40.28.h),
        Center(
          child: Container(
            width: 15.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: Color(0xff22C55E),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 12,
                  spreadRadius: 0,
                  color: Color.fromRGBO(34, 197, 94, 0.6),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Center(
          child: Text(
            "Ready to Tap",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: AppColor.darkishBlueTextColor,
            ),
          ),
        ),

        SizedBox(width: 10.w),
        Center(
          child: Text(
            "Hold your device near a compatible reader.",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Color(0xff334155),
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Center(
          child: Container(
            width: 358.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: Color(0xff137FEC),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/mycare/tap.svg"),
                SizedBox(width: 12.w),
                Text(
                  "Tap to Activate",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 25.h),
        Center(
          child: Container(
            width: 368.w,
            height: 71.h,

            decoration: BoxDecoration(
              color: Colors.white,
              border: BoxBorder.all(color: Color(0xffE2E8F0), width: 1),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: -2,
                  color: AppColor.getShadowColor(0.05),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/mycare/Background.svg"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lost Card Mode",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkishBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Temporarily disable NFC",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff334155),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: Switch(
                          value: false,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          splashRadius: 0.0,
                          onChanged: (value) {},

                          activeColor: const Color(0xFF1E63F4),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Color(0xffE2E8F0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
      ],
    );
  }

  Widget topPartCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 46.w,
          height: 34.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),

            color: Color.fromRGBO(255, 255, 255, 0.1),
            border: BoxBorder.all(
              width: 1,

              color: Color.fromRGBO(255, 255, 255, 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12.w,
                height: 16.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  border: BoxBorder.all(
                    width: 1,

                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Container(
                width: 12.w,
                height: 16.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  border: BoxBorder.all(
                    width: 1,

                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              "NFC ACTIVE",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Colors.white,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(width: 7.66.w),
            SvgPicture.asset("assets/images/mycare/Icon(1).svg"),
          ],
        ),
      ],
    );
  }
}
