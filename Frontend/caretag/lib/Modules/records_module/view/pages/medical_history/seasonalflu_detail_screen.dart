import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SeasonalFluDetailScreen extends StatelessWidget {
  const SeasonalFluDetailScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB); // Bright Blue
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
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
          'Invoice Details',
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
      ),
      // --- BOTTOM ACTION BAR ---
      bottomNavigationBar: _buildBottomActions(context),

      // --- MAIN BODY ---
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Blue Curved Header
            _buildBlueHeader(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // 2. Status Badge
                  _buildStatusBadge(),
                  SizedBox(height: 24.h),

                  // 3. Patient & Date Split Card
                  _buildPatientDateCard(),
                  SizedBox(height: 16.h),

                  // 4. Treating Physician Card
                  _buildPhysicianCard(),
                  SizedBox(height: 16.h),

                  // 5. Condition Summary Card
                  _buildConditionSummaryCard(),
                  SizedBox(height: 24.h),

                  // 6. Treatment Timeline Card
                  _buildTreatmentTimelineCard(),
                  SizedBox(height: 24.h),

                  // 7. Linked Documents Section
                  _buildLinkedDocumentsSection(),
                  SizedBox(height: 40.h), // Padding before the bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // UI COMPONENTS
  // ==========================================

  Widget _buildBlueHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Seasonal Flu',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Diagnosis ID: #CB-2024-892',
            style: GoogleFonts.inter(
              color: Colors.blue.shade100,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD1FAE5), // Light green
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: const Color(0xFF059669),
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'RECOVERED',
            style: GoogleFonts.inter(
              color: const Color(0xFF059669),
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientDateCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Patient Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PATIENT',
                  style: GoogleFonts.inter(
                    color: greyLabel,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: greyText,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Alex\nMorgan',
                        style: GoogleFonts.inter(
                          color: darkText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(height: 40.h, width: 1.w, color: Colors.grey.shade200),
          SizedBox(width: 16.w),

          // Date Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DATE',
                  style: GoogleFonts.inter(
                    color: greyLabel,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: greyText,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Sep 12,\n2023',
                        style: GoogleFonts.inter(
                          color: darkText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
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
    );
  }

  Widget _buildPhysicianCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: primaryBlue, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Mahendra Patel',
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'General Practitioner',
                  style: GoogleFonts.inter(color: greyText, fontSize: 13.sp),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildConditionSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // Light blue box matching design
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEFF6FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: primaryBlue, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'A viral infection that attacks your respiratory system. Characterized by high fever, chills, and muscle aches.',
              style: GoogleFonts.inter(
                color: const Color(0xFF4B5563),
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentTimelineCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Treatment Timeline',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          SizedBox(height: 24.h),

          // 🚨 CRASH-FREE TIMELINE USING STACK 🚨
          Stack(
            children: [
              // The continuous vertical grey line
              Positioned(
                left: 11.w, // Centers the line perfectly behind the dots
                top: 10.h,
                bottom: 30.h,
                child: Container(width: 2.w, color: Colors.grey.shade200),
              ),

              // The Timeline Items
              Column(
                children: [
                  _buildTimelineItem(
                    dotColor: primaryBlue, // Blue dot
                    date: 'Sep 12, 02:30 PM',
                    title: 'First Consultation',
                    subtitle: 'Initial symptoms and diagnosis.',
                  ),
                  _buildTimelineItem(
                    dotColor: Colors.grey.shade300, // Light grey dot
                    date: 'Sep 12, 03:00 PM',
                    title: 'Treatment Advised',
                    subtitle: 'Rest, hydration, and fever meds.',
                  ),
                  _buildTimelineItem(
                    dotColor: const Color(0xFF10B981), // Green dot
                    date: 'Sep 15, 10:00 AM',
                    title: 'Recovery Confirmed',
                    subtitle: 'Full recovery confirmed by physician.',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required Color dotColor,
    required String date,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot with solid white background to "cut" the grey line behind it
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.circle, size: 12.sp, color: dotColor),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: greyLabel,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: greyText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Linked Documents',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 130.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDocCard(
                icon: Icons.receipt_long_outlined,
                iconColor: const Color(0xFFEA580C), // Orange
                iconBg: const Color(0xFFFFF7ED),
                title: 'Prescription',
                subtitle: 'Sep 12',
              ),
              SizedBox(width: 16.w),
              _buildDocCard(
                icon: Icons.description_outlined,
                iconColor: const Color(0xFF9333EA), // Purple
                iconBg: const Color(0xFFF3E8FF),
                title: 'Flu Test',
                subtitle: 'Sep 12',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: darkText,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(fontSize: 11.sp, color: greyLabel),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // BOTTOM ACTION BAR
  // ==========================================
  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: 32.h,
      ), // Safe area bottom padding
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20.r,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Outline Button
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 54.h,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: darkText,
                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                icon: Icon(
                  Icons.chat_bubble_outline,
                  size: 18.sp,
                  color: darkText,
                ),
                label: Text(
                  'Consult\nDoctor',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Filled Button
          Expanded(
            flex: 3,
            child: SizedBox(
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
                  Icons.download_outlined,
                  size: 18.sp,
                  color: Colors.white,
                ),
                label: Text(
                  'Download\nSummary',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // PDF GENERATION LOGIC
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
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  color: PdfColors.blue600,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Seasonal Flu',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.Text(
                        'Diagnosis ID: #CB-2024-892',
                        style: const pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.blue100,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Status: RECOVERED',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.green600,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Divider(thickness: 1, color: PdfColors.grey300),
                pw.SizedBox(height: 24),

                // Patient Info
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPdfDataColumn('Patient Name', 'Alex Morgan'),
                    _buildPdfDataColumn('Date', 'Sep 12, 2023'),
                  ],
                ),
                pw.SizedBox(height: 20),
                _buildPdfDataColumn(
                  'Treating Physician',
                  'Dr. Mahendra Patel (General Practitioner)',
                ),
                pw.SizedBox(height: 32),

                // Summary
                pw.Text(
                  'Condition Summary',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'A viral infection that attacks your respiratory system. Characterized by high fever, chills, and muscle aches.',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey800,
                    lineSpacing: 1.5,
                  ),
                ),
                pw.SizedBox(height: 32),

                // Timeline
                pw.Text(
                  'Treatment Timeline',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                _buildPdfTimelineRow(
                  'Sep 12, 02:30 PM',
                  'First Consultation',
                  'Initial symptoms and diagnosis.',
                ),
                pw.SizedBox(height: 12),
                _buildPdfTimelineRow(
                  'Sep 12, 03:00 PM',
                  'Treatment Advised',
                  'Rest, hydration, and fever meds.',
                ),
                pw.SizedBox(height: 12),
                _buildPdfTimelineRow(
                  'Sep 15, 10:00 AM',
                  'Recovery Confirmed',
                  'Full recovery confirmed by physician.',
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Seasonal_Flu_Summary.pdf',
    );
  }

  pw.Widget _buildPdfDataColumn(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget _buildPdfTimelineRow(String date, String title, String subtitle) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 100,
          child: pw.Text(
            date,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              subtitle,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ),
      ],
    );
  }
}
