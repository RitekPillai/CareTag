import 'package:caretag/Modules/records_module/view/pages/medical_records/fly_to_fly_cerificate_detail.dart';
import 'package:caretag/Modules/records_module/view/pages/medical_records/hospital_calim_screen.dart';
import 'package:caretag/Modules/records_module/view/pages/medical_records/license_revewnal.dart';
import 'package:caretag/Modules/records_module/view/pages/medical_records/medical_fitness_certificate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OfficialDocumentsView extends StatelessWidget {
  const OfficialDocumentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 🚨 Prevents scrollview crashes
        children: [
          SizedBox(height: 10.h),

          // --- HEADER ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Official Documents',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827), // Dark text
                ),
              ),
              Text(
                '4 Documents',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280), // Grey text
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // --- LIST OF DOCUMENTS ---
          Column(
            children: [
              // Card 1: Medical Fitness
              OfficialDocumentCard(
                title: 'General Medical Fitness',
                issuer: 'Issued by Dr. Sarah Jenkins',
                details: 'MFC-2023-8921 • Pre-employment',
                date: 'Oct 24,\n2023',
                status: 'VALID',
                signature: 'S. Jenkins',
                iconData: Icons.health_and_safety_outlined,
                iconBgColor: const Color(0xFFEFF6FF), // Light Blue
                iconColor: const Color(0xFF2563EB), // Blue
                statusBgColor: const Color(0xFFD1FAE5), // Light Green
                statusColor: const Color(0xFF059669), // Green
                widget: MedicalCertificateScreen(),
              ),
              SizedBox(height: 16.h),

              // Card 2: Fit to Fly
              OfficialDocumentCard(
                title: 'Fit-to-Fly Certificate',
                issuer: 'Issued by Dr. Mark Roe',
                details: 'International Travel Clearance • Exp: Dec 2025',
                date: 'Nov 12,\n2023',
                status: 'VALID',
                signature: 'M. Roe',
                iconData: Icons.flight_takeoff_outlined,
                iconBgColor: const Color(0xFFE0F2FE), // Lighter Blue
                iconColor: const Color(0xFF0284C7), // Sky Blue
                statusBgColor: const Color(0xFFD1FAE5), // Light Green
                statusColor: const Color(0xFF059669), // Green
                widget: FitToFlyScreen(),
              ),
              SizedBox(height: 16.h),

              // Card 3: Medical Claim
              OfficialDocumentCard(
                title: 'Medical Claim Cert.',
                issuer: 'Issued by City General Hospital',
                details: 'Claim ID: INS-9032 • Hospitalization',
                date: 'Oct 05,\n2023',
                status: 'PAID',
                signature: 'City Gen.',
                iconData: Icons.assignment_ind_outlined,
                iconBgColor: const Color(0xFFEEF2FF), // Indigo Light
                iconColor: const Color(0xFF4F46E5), // Indigo
                statusBgColor: const Color(0xFFDBEAFE), // Light Blue
                statusColor: const Color(0xFF2563EB), // Blue
                widget: HospitalizationClaimScreen(),
              ),
              SizedBox(height: 16.h),

              // Card 4: Driving Fitness
              OfficialDocumentCard(
                title: 'Driving Fitness',
                issuer: 'Issued by Medical Board',
                details: 'License Renewal Clearance • Ref: DL-4421',
                date: 'Aug 18,\n2023',
                status: 'VERIFIED',
                signature: 'Med. Board',
                iconData: Icons.directions_car_outlined,
                iconBgColor: const Color(0xFFF3E8FF), // Light Purple
                iconColor: const Color(0xFF9333EA), // Purple
                statusBgColor: const Color(0xFFF3E8FF), // Light Purple
                statusColor: const Color(0xFF9333EA), // Purple
                widget: LicenseRenewalScreen(),
              ),
              SizedBox(height: 24.h),

              // --- BOTTOM INFO BANNER ---
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
                      Icons.info_outline,
                      color: const Color(0xFF2563EB),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'These documents are official digital copies. For physical stamped copies, please visit the clinic reception.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2563EB),
                          fontSize: 12.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
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
// REUSABLE DOCUMENT CARD WIDGET
// ==========================================

class OfficialDocumentCard extends StatelessWidget {
  final String title;
  final String issuer;
  final String details;
  final String date;
  final String status;
  final String signature;
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final Color statusBgColor;
  final Color statusColor;
  final Widget widget;

  const OfficialDocumentCard({
    Key? key,
    required this.title,
    required this.issuer,
    required this.details,
    required this.date,
    required this.status,
    required this.signature,
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.statusBgColor,
    required this.statusColor,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2563EB);
    const Color darkText = Color(0xFF111827);
    const Color lightText = Color(0xFF6B7280);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
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
        clipBehavior: Clip
            .hardEdge, // Keeps the watermark and side border cleanly inside the corners
        child: Stack(
          children: [
            // --- LEFT BLUE ACCENT LINE ---
            // Using a stack avoids IntrinsicHeight crashes completely!
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(width: 5.w, color: primaryBlue),
            ),

            // --- BACKGROUND WATERMARK ---
            Positioned(
              right: -20.w,
              top: 10.h,
              child: Icon(
                iconData,
                size: 130.sp,
                color: iconBgColor.withOpacity(
                  0.6,
                ), // Faint tint of the main color
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
                          color: iconBgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(iconData, color: iconColor, size: 24.sp),
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
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              issuer,
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: lightText,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              details,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey.shade400,
                                height: 1.3,
                              ),
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
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusBgColor,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.inter(
                                color: statusColor,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            date,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: Colors.grey.shade400,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  Divider(color: Colors.grey.shade100, thickness: 1.5),
                  SizedBox(height: 12.h),

                  // Bottom Row (Signature & Download Button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Stylized Signature
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Faint background icon to mimic the scribble watermark in the design
                          Icon(
                            Icons.gesture,
                            color: iconBgColor.withOpacity(0.8),
                            size: 36.sp,
                          ),
                          Text(
                            signature,
                            style: GoogleFonts.playfairDisplay(
                              // Cursive/Serif styling
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                        ],
                      ),

                      // Download Button
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
                                Icons.download_outlined,
                                size: 16.sp,
                                color: const Color(0xFF374151),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Download',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF374151),
                                  fontSize: 13.sp,
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
