import 'package:caretag/Modules/records_module/view/pages/vaccination_invoice/covid_report.dart';
import 'package:caretag/Modules/records_module/view/pages/vaccination_invoice/hepatitsb_report.dart';
import 'package:caretag/Modules/records_module/view/pages/vaccination_invoice/vaccination_invoice_flut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VaccinationReportsView extends StatelessWidget {
  const VaccinationReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 🚨 Keeps it from expanding infinitely
        children: [
          SizedBox(height: 10.h),
          // --- HEADER ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Vaccination History',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827), // Dark text
                ),
              ),
              Text(
                '4 Records',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280), // Grey text
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // --- LIST OF VACCINES ---
          // Using a Column here instead of ListView avoids all scrolling crashes
          // since the parent Records screen already has a SingleChildScrollView!
          Column(
            children: [
              VaccinationTile(
                title: 'COVID-19 Booster',
                issuer: 'Issued by City Hospital',
                details: 'Dose 3/3 • Pfizer',
                date: 'Feb 12, 2024',
                hospitalName: 'City Hosp.',
                iconData: Icons.vaccines_outlined,
                iconBgColor: const Color(0xFFEFF6FF), // Light Blue
                iconColor: const Color(0xFF3B82F6), // Blue
                watermarkIcon: Icons.coronavirus_outlined,
                isCompleted: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VaccinationBoosterScreen(),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              VaccinationTile(
                title: 'Influenza (Flu)',
                issuer: 'Issued by Pari Clinic',
                details: 'Annual Shot',
                date: 'Oct 15, 2023',
                hospitalName: 'Pari Clinic',
                iconData: Icons.medical_services_outlined,
                iconBgColor: const Color(0xFFFFF7ED), // Light Orange
                iconColor: const Color(0xFFEA580C), // Orange
                watermarkIcon: Icons.masks_outlined,
                isCompleted: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FluInvoice()),
                ),
              ),
              SizedBox(height: 16.h),

              VaccinationTile(
                title: 'Hepatitis B',
                issuer: 'Issued by Apollo Medical',
                details: 'Dose 2/3',
                date: 'Jan 05, 2024',
                hospitalName: 'Apollo Med',
                iconData: Icons.shield_outlined,
                iconBgColor: const Color(0xFFF3E8FF), // Light Purple
                iconColor: const Color(0xFF9333EA), // Purple
                watermarkIcon: Icons.health_and_safety_outlined,
                isCompleted: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => hepatitsbReport()),
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

class VaccinationTile extends StatelessWidget {
  final String title;
  final String issuer;
  final String details;
  final String date;
  final String hospitalName;
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final IconData watermarkIcon;
  final bool isCompleted;
  final VoidCallback onTap;

  const VaccinationTile({
    Key? key,
    required this.title,
    required this.issuer,
    required this.details,
    required this.date,
    required this.hospitalName,
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.watermarkIcon,
    this.isCompleted = true,
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
          borderRadius: BorderRadius.circular(20.r),
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
            Clip.hardEdge, // Keeps the watermark inside the rounded corners
        child: Stack(
          children: [
            // --- BACKGROUND WATERMARK ---
            Positioned(
              right: -20.w,
              top: 10.h,
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
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Badge & Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (isCompleted)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5), // Light green
                                borderRadius: BorderRadius.circular(
                                  12.r,
                                ), // Pill shape
                              ),
                              child: Text(
                                'COMPLETED',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF059669), // Dark green
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          SizedBox(height: 8.h),
                          Text(
                            date,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  Divider(color: Colors.grey.shade100, thickness: 1.5),
                  SizedBox(height: 12.h),

                  // Bottom Row (Hospital Logo & Download)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Fake stylized logo from the image
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.shade400,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            hospitalName,
                            style: GoogleFonts.playfairDisplay(
                              // Gives that cursive/stylized look
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      // Download Button
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.download_outlined,
                          size: 16.sp,
                          color: Colors.black54,
                        ),
                        label: Text(
                          'Download',
                          style: GoogleFonts.inter(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
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
