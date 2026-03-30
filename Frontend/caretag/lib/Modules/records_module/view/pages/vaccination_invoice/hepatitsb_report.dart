import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class hepatitsbReport extends StatelessWidget {
  const hepatitsbReport({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB);
  final Color darkText = const Color(0xFF111827);
  final Color greyText = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Invoice Details', // From your design
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- 1. TOP HEADER CARD ---
            _buildTopHeaderCard(),

            SizedBox(height: 24.h),

            // --- 2. TIMELINE CARD ---
            _buildTimelineCard(),

            SizedBox(height: 32.h),

            // --- 3. BOTTOM BUTTONS ---
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () => _generateAndDownloadPdf(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                icon: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                label: Text(
                  'Download PDF Report',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Reminder set for Next Year',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: const Color(0xFF059669), // Success Green
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      margin: EdgeInsets.all(20.w),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryBlue,
                  side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: primaryBlue,
                  size: 20.sp,
                ),
                label: Text(
                  'Set Reminder for Next Year',
                  style: GoogleFonts.inter(
                    color: primaryBlue,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // TOP HEADER CARD
  // ==========================================
  Widget _buildTopHeaderCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: const BoxDecoration(
              color: Color(0xFFF3E8FF), // Light purple
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              color: const Color(0xFF9333EA),
              size: 36.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Hepatitis B',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: const Color(0xFF059669),
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'COMPLETED',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF059669),
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'You are up to date with your current schedule.',
            style: GoogleFonts.inter(color: greyText, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TIMELINE CARD
  // ==========================================
  Widget _buildTimelineCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart, color: primaryBlue, size: 22.sp),
              SizedBox(width: 8.w),
              Text(
                'Vaccination Timeline',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Timeline Items
          _buildTimelineItem(
            title: 'Dose 1',
            subtitle: 'Initial Dose',
            date: 'Aug 05, 2023',
            status: 'Completed',
            isFirst: true,
            isLast: false,
            isActive: false,
          ),
          _buildTimelineItem(
            title: 'Dose 2',
            subtitle: 'Second Dose',
            date: 'Jan 05, 2024',
            status: 'Completed',
            isFirst: false,
            isLast: false,
            isActive: true, // The highlighted blue row
          ),
          _buildTimelineItem(
            title: 'Dose 3',
            subtitle: 'Final Booster',
            date: 'Due July 05, 2024',
            status: 'Pending',
            isFirst: false,
            isLast: true,
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String date,
    required String status,
    required bool isFirst,
    required bool isLast,
    required bool isActive,
  }) {
    final bool isCompleted = status == 'Completed';
    final Color statusColor = isCompleted
        ? const Color(0xFF059669)
        : const Color(0xFFF59E0B); // Green vs Orange

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- LEFT COLUMN (Lines & Icons) ---
          SizedBox(
            width: 30.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Vertical Line
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 2.w,
                        color: isFirst
                            ? Colors.transparent
                            : Colors.grey.shade200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 2.w,
                        color: isLast
                            ? Colors.transparent
                            : Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
                // Center Icon
                Container(
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: _getTimelineIcon(isCompleted, isActive),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // --- RIGHT COLUMN (Text Content) ---
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFEFF6FF)
                    : Colors.transparent, // Light blue highlight
                borderRadius: BorderRadius.circular(16.r),
                border: isActive
                    ? Border.all(color: const Color(0xFFBFDBFE), width: 1)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: isActive ? primaryBlue : darkText,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: greyText,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        status,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          color: statusColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        date,
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: greyText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTimelineIcon(bool isCompleted, bool isActive) {
    if (isActive) {
      return Icon(Icons.radio_button_checked, color: primaryBlue, size: 20.sp);
    } else if (isCompleted) {
      return Icon(
        Icons.check_circle,
        color: const Color(0xFF059669),
        size: 20.sp,
      );
    } else {
      return Icon(Icons.circle, color: Colors.grey.shade300, size: 16.sp);
    }
  }

  // ==========================================
  // PDF GENERATION
  // ==========================================
  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Vaccination Record',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Hepatitis B',
                  style: pw.TextStyle(fontSize: 20, color: PdfColors.blue800),
                ),
                pw.Text(
                  'Status: COMPLETED',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.green600,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 40),
                pw.Divider(thickness: 1, color: PdfColors.grey300),
                pw.SizedBox(height: 24),

                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    'Vaccination Timeline',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 24),

                _buildPdfTimelineRow(
                  'Dose 1',
                  'Initial Dose',
                  'Completed',
                  'Aug 05, 2023',
                ),
                pw.SizedBox(height: 16),
                _buildPdfTimelineRow(
                  'Dose 2',
                  'Second Dose',
                  'Completed',
                  'Jan 05, 2024',
                ),
                pw.SizedBox(height: 16),
                _buildPdfTimelineRow(
                  'Dose 3',
                  'Final Booster',
                  'Pending',
                  'Due July 05, 2024',
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Hepatitis_B_Record.pdf',
    );
  }

  pw.Widget _buildPdfTimelineRow(
    String title,
    String subtitle,
    String status,
    String date,
  ) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              subtitle,
              style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              status,
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: status == 'Completed'
                    ? PdfColors.green600
                    : PdfColors.orange600,
              ),
            ),
            pw.Text(
              date,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }
}
