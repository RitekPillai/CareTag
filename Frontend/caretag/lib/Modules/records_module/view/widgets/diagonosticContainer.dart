import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Diagonosticcontainer extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String condition;
  final String date;
  final String clinic;
  final String status;
  final String doctorImage;
  final VoidCallback? onDownload;
  final VoidCallback? onViewDetails;

  const Diagonosticcontainer({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.condition,
    required this.date,
    required this.clinic,
    required this.status,
    required this.doctorImage,
    this.onDownload,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBlueTextColor = Color(0xff111827);
    const Color lightGrayTextColor = Color(0xff6B7280);
    const Color greenTextColor = Color(0xff16A34A);
    const Color containerColor = Color(0xffF0FDF4);
    const Color lightGreyTextColor = Color(0xff9CA3AF);
    return Container(
      width: 265.w,
      height: 220.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Container(
                  width: 46.69.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(doctorImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Padding(
                padding: EdgeInsets.only(right: 11, top: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 101.73.w,
                      child: Text(
                        doctorName,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: darkBlueTextColor,
                        ),
                      ),
                    ),
                    Text(
                      specialty,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: lightGrayTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 16.w, top: 16.h),
                child: Container(
                  width: 60.47.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Center(
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: greenTextColor,
                      ),
                    ),
                  ),
                ),
              ),

              // SizedBox(height: 16.h),
              // // Action Buttons
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Expanded(
              //       child: GestureDetector(
              //         onTap: onViewDetails,
              //         child: Text(
              //           'View Details >',
              //           style: GoogleFonts.poppins(
              //             fontSize: 13.sp,
              //             fontWeight: FontWeight.w600,
              //             color: Color(0xff999999),
              //           ),
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 8.w),
              //     ElevatedButton(
              //       onPressed: onDownload,
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xff0063F7),
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 12.w,
              //           vertical: 10.h,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12.r),
              //         ),
              //       ),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Icon(Icons.download, size: 16.sp, color: Colors.white),
              //           SizedBox(width: 4.w),
              //           Text(
              //             'Download',
              //             style: GoogleFonts.poppins(
              //               fontSize: 12.sp,
              //               fontWeight: FontWeight.w600,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 16.h),
            child: Text(
              condition,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.lightBlueTextColor2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 4.h),
            child: Row(
              children: [
                Icon(Icons.calendar_month_rounded, color: Color(0xff9CA3AF)),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    date,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: lightGreyTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.location_on_outlined, color: Color(0xff9CA3AF)),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    clinic,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: lightGreyTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.w),

          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onViewDetails,
                    child: Text(
                      'View Details >',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff999999),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: onDownload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0063F7),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, size: 16.sp, color: Colors.white),
                      SizedBox(width: 4.w),
                      Text(
                        'Download',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
