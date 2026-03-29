import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_list_model.dart';
import 'package:caretag/Modules/%20Diagonostic/model_view/bloc/diagonostic_bloc.dart';
import 'package:caretag/Modules/%20Diagonostic/view/pages/diagonostic_Detail_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DigonissiNearbyTie extends StatelessWidget {
  final DiagonosticListModel diagonosticList;
  const DigonissiNearbyTie({super.key, required this.diagonosticList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        border: BoxBorder.all(color: AppColor.whiteCreamColor),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: AppColor.getShadowColor(0.05),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 5.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              width: 80.w,
              height: 80.h,
              diagonosticList.imageUrl,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text(
                diagonosticList.diagonosticName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: AppColor.darkishColor,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Work Days:${diagonosticList.workDays}",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Color(0xff618986),
                ),
              ),
              SizedBox(height: 19.h),
              Row(
                children: [
                  Icon(Icons.timelapse),
                  SizedBox(width: 2.75),
                  Text(
                    "Available: ${diagonosticList.worktTime}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Color(0xff618986),
                    ),
                  ),
                  SizedBox(width: 19.88.w),
                  GestureDetector(
                    onTap: () {
                      context.read<DiagonosticBloc>().add(
                        GetDiagonosticDetail(id: diagonosticList.id),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagnosticDetailsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 96.72.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        border: Border.all(color: Color(0xffE5E7EB)),
                      ),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColor.darkishColor,
                          ),
                        ),
                      ),
                    ),
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
