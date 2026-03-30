import 'package:caretag/Modules/records_module/view/pages/insurance_pages/ER_Visit_detail_screen.dart';
import 'package:caretag/Modules/records_module/view/pages/insurance_pages/dental_insurance_detail.dart';
import 'package:caretag/Modules/records_module/view/pages/insurance_pages/knee_surgey_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InsurancePolicy extends StatelessWidget {
  const InsurancePolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 🚨 Prevents scrollview crashes
        children: [
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Claims Tracker',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827), // Dark text
                ),
              ),
              Text(
                '3 Records',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280), // Grey text
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          Column(
            children: [
              ClaimCard(
                title: 'Knee Surgery Claim',
                hospital: 'Apollo Hospital',
                details: '₹1,20,000 • Claim ID: INS-4421',
                date: 'Oct 24, 2024',
                status: 'IN REVIEW',
                initials: 'AH',
                actionText: 'Track Status',
                actionIcon: Icons.show_chart,
                primaryColor: const Color(0xFFD97706), // Dark Orange
                bgColor: const Color(0xFFFFFBEB), // Light Orange/Yellow
                iconData: Icons.receipt_long_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KneeSurgeyDetailScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),

              ClaimCard(
                title: 'Dental Consultation',
                hospital: 'Pari Clinic',
                details: '₹1,500 • Claim ID: INS-3398',
                date: 'Sep 15, 2024',
                status: 'SETTLED',
                initials: 'PC',
                actionText: 'View Settlement',
                actionIcon: Icons.description_outlined,
                primaryColor: const Color(0xFF059669), // Dark Green
                bgColor: const Color(0xFFD1FAE5), // Light Green
                iconData: Icons.health_and_safety_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DentalClaimScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),

              ClaimCard(
                title: 'ER Visit',
                hospital: 'City Hospital',
                details: '₹15,000 • Missing Documentation',
                date: 'Aug 10,\n2024', // Split line per design
                status: 'REJECTED',
                initials: 'CH',
                actionText: 'Re-submit',
                actionIcon: Icons.restore,
                primaryColor: const Color(0xFFDC2626), // Dark Red
                bgColor: const Color(0xFFFEE2E2), // Light Red
                iconData: Icons.emergency_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ERVisitClaimScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),

              // --- BOTTOM ACTIVE POLICY BANNER ---
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF), // Light blue tint
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFBFDBFE), width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: const Color(0xFF2563EB),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Active Policy: CarePlus Family Plan (Expires in 45 days)',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2563EB),
                          fontSize: 13.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h), // Bottom padding
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// REUSABLE CLAIM TILE WIDGET
// ==========================================

class ClaimCard extends StatelessWidget {
  final String title;
  final String hospital;
  final String details;
  final String date;
  final String status;
  final String initials;
  final String actionText;
  final IconData actionIcon;
  final Color primaryColor;
  final Color bgColor;
  final IconData iconData;
  final VoidCallback onTap;

  const ClaimCard({
    Key? key,
    required this.title,
    required this.hospital,
    required this.details,
    required this.date,
    required this.status,
    required this.initials,
    required this.actionText,
    required this.actionIcon,
    required this.primaryColor,
    required this.bgColor,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkText = Color(0xFF111827);
    const Color lightText = Color(0xFF6B7280);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior:
            Clip.hardEdge, // Keeps the watermark cleanly inside the borders
        child: Stack(
          children: [
            // --- BACKGROUND WATERMARK ---
            Positioned(
              right: -10.w,
              top: 20.h,
              child: Icon(
                iconData,
                size: 110.sp,
                color: primaryColor.withOpacity(
                  0.05,
                ), // Very faint tint of the main color
              ),
            ),

            // --- MAIN CONTENT ---
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circular Icon
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(iconData, color: primaryColor, size: 24.sp),
                      ),
                      SizedBox(width: 16.w),

                      // Text Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: darkText,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              hospital,
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: lightText,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              details,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey.shade500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // Badge & Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.inter(
                                color: primaryColor,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            date,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  Divider(color: Colors.grey.shade100, thickness: 1.5),
                  SizedBox(height: 12.h),

                  // Bottom Row (Hospital Initials & Action Button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar and Hospital Name
                      Expanded(
                        // Prevents long hospital names from pushing the button off screen
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                initials,
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF374151), // Dark grey
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                hospital,
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // Action Button
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF3F4F6,
                            ), // Very light grey bg
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                actionIcon,
                                size: 16.sp,
                                color: const Color(0xFF374151),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                actionText,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF374151),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
