import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertBox extends StatelessWidget {
  final String docName;
  final String hospitalName;
  const CustomAlertBox({
    super.key,
    required this.docName,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    const Color redColor = Color(0xffEF4444);
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
                "Records Access Request",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: AppColor.darkishBlueTextColor,
                ),
              ),
              SizedBox(height: 7.32.h),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: docName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.darkishBlueTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: " from ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "$hospitalName\n",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColor.darkishBlueTextColor,
                          ),
                          children: [
                            TextSpan(
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              text: "is requesting temporary access to your ",
                            ),
                            TextSpan(
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              text:
                                  "medical records for your upcoming consultation",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              customElevatedButton(
                52.h,
                310.w,
                "Approve Access",
                16,
                FontWeight.w700,
                () {},
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Deny",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColor.greyTextColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.flag_outlined, color: redColor),
                      Text(
                        "Report",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
