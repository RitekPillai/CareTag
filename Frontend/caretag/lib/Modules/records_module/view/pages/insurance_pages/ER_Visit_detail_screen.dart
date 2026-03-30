import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ERVisitClaimScreen extends StatelessWidget {
  const ERVisitClaimScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB);
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF6B7280);
  final Color redWarning = const Color(0xFFDC2626); // Dark Red
  final Color lightRedBg = const Color(0xFFFEF2F2); // Very Light Red

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ER Visit Claim',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. REJECTED WARNING BANNER ---
            _buildWarningBanner(),
            SizedBox(height: 32.h),

            // --- 2. CLAIM SUMMARY ---
            _buildClaimSummary(),
            SizedBox(height: 40.h),

            // --- 3. WHAT WE NEED SECTION ---
            Text(
              'What we need',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
            SizedBox(height: 20.h),

            _buildRequirementItem(
              icon: Icons.check_circle_outline,
              iconColor: const Color(0xFF10B981),
              title: 'Original Hospital Bill',
              badgeText: 'VERIFIED',
              badgeColor: const Color(0xFF10B981),
              badgeBg: const Color(0xFFD1FAE5),
              isMissing: false,
            ),
            SizedBox(height: 12.h),

            _buildRequirementItem(
              icon: Icons.error_outline,
              iconColor: redWarning,
              title: "Doctor's Prescription/Notes",
              badgeText: 'MISSING',
              badgeColor: redWarning,
              badgeBg: const Color(
                0xFFFECACA,
              ), // Slightly darker red bg for badge
              isMissing: true,
            ),
            SizedBox(height: 32.h),

            // --- 4. UPLOAD SECTION ---
            Text(
              'Attach Documents',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B5563),
              ),
            ),
            SizedBox(height: 12.h),
            _buildUploadBox(),

            SizedBox(height: 40.h),

            // --- 5. BOTTOM BUTTON ---
            _buildBottomAction(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // UI COMPONENTS
  // ==========================================

  Widget _buildWarningBanner() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: lightRedBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFECACA),
          width: 1.5,
        ), // Red border
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFB91C1C),
            size: 24.sp,
          ), // Deep red icon
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REJECTED: Missing\nDocumentation',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFB91C1C),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Dr. Sarah Wilson's medical note was not found in the submission. This is required to verify the ER visit necessity.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4B5563),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CLAIM ID: INS-4421',
              style: GoogleFonts.inter(
                color: greyLabel,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'ER Visit - City Hospital',
              style: GoogleFonts.inter(
                color: darkText,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Aug 10, 2024',
              style: GoogleFonts.inter(color: greyText, fontSize: 13.sp),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹15,000',
              style: GoogleFonts.inter(
                color: darkText,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Action Required',
              style: GoogleFonts.inter(
                color: redWarning,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequirementItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBg,
    required bool isMissing,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isMissing ? lightRedBg : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              badgeText,
              style: GoogleFonts.inter(
                color: badgeColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox() {
    return CustomPaint(
      painter: DashedRectPainter(
        color: const Color(0xFF93C5FD),
        strokeWidth: 1.5,
        radius: 16.r,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC), // Extremely light grey/blue
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: Color(0xFFDBEAFE),
                shape: BoxShape.circle,
              ), // Light blue circle
              child: Icon(Icons.add, color: primaryBlue, size: 24.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'Upload Missing Doctor Note',
              style: GoogleFonts.inter(
                color: primaryBlue,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Supports PDF, JPG, PNG (Max 5MB)',
              style: GoogleFonts.inter(color: greyLabel, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54.h,
          child: ElevatedButton(
            onPressed: null, // Null disables the button natively
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: const Color(
                0xFFE5E7EB,
              ), // Grey background
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              'Re-submit Claim',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Please upload the required document to proceed.',
          style: GoogleFonts.inter(color: greyLabel, fontSize: 12.sp),
        ),
      ],
    );
  }
}

// ==========================================
// NATIVE DASHED RECTANGLE PAINTER
// ==========================================
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 6.0,
    this.dashSpace = 5.0,
    this.radius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    Path dashPath = Path();
    for (PathMetric measurePath in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < measurePath.length) {
        dashPath.addPath(
          measurePath.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
