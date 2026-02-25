// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:caretag/Modules/home/view.dart/homePage.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/constants/app_color.dart';

class ReportAlertbox extends StatelessWidget {
  final Permissionrequestmodel permissionrequestmodel;
  const ReportAlertbox({super.key, required this.permissionrequestmodel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 403.h,
      width: 360.w,
      child: AlertDialog(
        backgroundColor: Colors.white,

        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: AppColor.lightBlueSmallContainerColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/home/dialog/shiled.svg",
                    width: 20.w,
                    height: 25.h,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                textAlign: TextAlign.center,
                "Report Submitted\nSuccessfully",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: AppColor.darkishBlueTextColor,
                ),
              ),
              SizedBox(height: 7.32.h),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: permissionrequestmodel.docName,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.greyTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: " and ",

                      children: [
                        TextSpan(
                          text: "${permissionrequestmodel.placeName}\n",

                          children: [
                            TextSpan(
                              text:
                                  " have been restricted from sending further requests.",
                            ),
                            TextSpan(
                              text:
                                  "Our security team will review  this incident shortly",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.44.h),
              customElevatedButton(
                56.h,
                342.w,
                "Back to Home",
                16.sp,
                FontWeight.w700,
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                32.r,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
