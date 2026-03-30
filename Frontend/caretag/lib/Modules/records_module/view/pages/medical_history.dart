import 'package:caretag/Modules/records_module/view/pages/medical_history/acute_medical_history.dart';
import 'package:caretag/Modules/records_module/view/pages/medical_history/diabete_history_detail.dart';
import 'package:caretag/Modules/records_module/view/pages/medical_history/seasonalflu_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalHistoryView extends StatelessWidget {
  const MedicalHistoryView({Key? key}) : super(key: key);

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
                'Diagnosis History',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827), // Dark text
                ),
              ),
              Text(
                '5 Records',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280), // Grey text
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // --- LIST OF DIAGNOSES ---
          Column(
            children: [
              DiagnosisTile(
                title: 'Acute Bronchitis',
                doctorName: 'Dr. Sarah Wilson',
                note: '5-day antibiotic course completed.',
                date: 'Oct 24, 2024',
                signatureText: 'City Clinic',
                status: 'RECOVERED',
                iconData: Icons.air_outlined, // Lungs representation
                iconBgColor: const Color(0xFFEFF6FF), // Light Blue
                iconColor: const Color(0xFF3B82F6), // Blue
                watermarkIcon: Icons.air,
                signatureIcon: Icons.local_hospital_outlined,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalHistoryDetailScreen(),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              DiagnosisTile(
                title: 'Seasonal Flu',
                doctorName: 'Dr. Mahendra Patel',
                note: 'Rest and hydration advised.',
                date: 'Sep 15, 2023',
                signatureText: 'Dr. Patel',
                status: 'RECOVERED',
                iconData: Icons.thermostat_outlined,
                iconBgColor: const Color(0xFFFFF7ED), // Light Orange
                iconColor: const Color(0xFFEA580C), // Orange
                watermarkIcon: Icons.thermostat,
                signatureIcon: Icons.edit_note_outlined,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeasonalFluDetailScreen(),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              DiagnosisTile(
                title: 'Type 2 Diabetes',
                doctorName: 'Dr. Rakesh Kumar',
                note: 'Continuous glucose monitoring.',
                date: 'Jan 05,\n2024', // Split line per design
                signatureText: 'Dr. Kumar',
                status: 'ACTIVE',
                iconData: Icons.bloodtype_outlined,
                iconBgColor: const Color(0xFFF3E8FF), // Light Purple
                iconColor: const Color(0xFF9333EA), // Purple
                watermarkIcon: Icons.back_hand_outlined,
                signatureIcon: Icons.shield_outlined,

                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiabetesDetailScreen(),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // --- BOTTOM SYNC BANNER ---
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
                      Icons.swap_horiz,
                      color: const Color(0xFF2563EB),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Medical history is automatically synced from your verified consultations.',
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
// REUSABLE TILE WIDGET
// ==========================================

class DiagnosisTile extends StatelessWidget {
  final String title;
  final String doctorName;
  final String note;
  final String date;
  final String signatureText;
  final String status;
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final IconData watermarkIcon;
  final IconData signatureIcon;
  final VoidCallback onTap;

  const DiagnosisTile({
    Key? key,
    required this.title,
    required this.doctorName,
    required this.note,
    required this.date,
    required this.signatureText,
    required this.status,
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.watermarkIcon,
    required this.signatureIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkText = Color(0xFF111827);
    const Color lightText = Color(0xFF6B7280);

    // Dynamic styles based on status
    final bool isRecovered = status == 'RECOVERED';
    final Color badgeBg = isRecovered
        ? const Color(0xFFD1FAE5)
        : const Color(0xFFEFF6FF);
    final Color badgeText = isRecovered
        ? const Color(0xFF059669)
        : const Color(0xFF2563EB);

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
        clipBehavior: Clip.hardEdge, // Keeps the watermark inside the borders
        child: Stack(
          children: [
            // --- BACKGROUND WATERMARK ---
            Positioned(
              right: -10.w,
              top: 20.h,
              child: Icon(
                watermarkIcon,
                size: 110.sp,
                color: iconColor.withOpacity(
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
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              doctorName,
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: lightText,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              note,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey.shade400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

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
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.inter(
                                color: badgeText,
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

                  // Bottom Row (Signature & View Summary Button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Fake stylized signature from the image
                      Row(
                        children: [
                          Icon(
                            signatureIcon,
                            color: Colors.grey.shade400,
                            size: 24.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            signatureText,
                            style: GoogleFonts.playfairDisplay(
                              // Gives the cursive signature look
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      // View Summary Button
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
                                Icons.description_outlined,
                                size: 16.sp,
                                color: const Color(0xFF374151),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'View Summary',
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
