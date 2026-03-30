import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DiabetesDetailScreen extends StatelessWidget {
  const DiabetesDetailScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB);
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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

                  // 2. Active Status Badge
                  _buildStatusBadge(),
                  SizedBox(height: 24.h),

                  // 3. Patient & Date Split Card
                  _buildPatientDateCard(),
                  SizedBox(height: 16.h),

                  // 4. Treating Physician Card with Verified Badge
                  _buildPhysicianCard(),
                  SizedBox(height: 16.h),

                  // 5. Condition Summary Card
                  _buildConditionSummaryCard(),
                  SizedBox(height: 24.h),

                  // 6. Rich Treatment Timeline
                  _buildTreatmentTimelineSection(),
                  SizedBox(height: 24.h),

                  // 7. Linked Documents Section
                  _buildLinkedDocumentsSection(),
                  SizedBox(height: 40.h),
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
            'Type 2 Diabetes',
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
        color: const Color(0xFFFFFBEB), // Light yellow/orange
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFFEF3C7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shield,
            color: const Color(0xFFD97706),
            size: 16.sp,
          ), // Orange shield
          SizedBox(width: 8.w),
          Text(
            'ACTIVE',
            style: GoogleFonts.inter(
              color: const Color(0xFFB45309), // Dark Orange
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
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
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
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
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
          // Doctor Avatar with Stacked Checkmark
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_outline, color: greyText, size: 24.sp),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: const Color(0xFF10B981),
                    size: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Rakesh Kumar',
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Endocrinologist',
                  style: GoogleFonts.inter(
                    color: primaryBlue,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
        color: const Color(0xFFEFF6FF), // Light blue box
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
              'A chronic condition that affects the way your body processes blood sugar. Requires consistent monitoring and lifestyle management.',
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

  Widget _buildTreatmentTimelineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Treatment Timeline',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
            Text(
              'HISTORY',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: greyLabel,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Stack(
            children: [
              // Vertical grey line
              Positioned(
                left: 11.w,
                top: 10.h,
                bottom: 30.h,
                child: Container(width: 2.w, color: Colors.grey.shade200),
              ),

              // Timeline Events
              Column(
                children: [
                  _buildRichTimelineItem(
                    dotColor: greyLabel,
                    date: 'Jan 05, 2024',
                    title: 'Initial Diagnosis',
                    customContent: Container(
                      margin: EdgeInsets.only(top: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Treatment plan: Metformin 500mg (1-0-1)',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ),
                  _buildRichTimelineItem(
                    dotColor: greyLabel,
                    date: 'Sep 10, 2024',
                    title: 'Lab Review',
                    subtitle: 'Metabolic markers within stable range.',
                  ),
                  _buildRichTimelineItem(
                    dotColor: const Color(0xFF10B981), // Green dot
                    date: 'Dec 12, 2024',
                    title: 'Routine Check',
                    dateColor: const Color(0xFF10B981), // Green date text
                    customContent: Container(
                      margin: EdgeInsets.only(top: 8.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 14.sp,
                                color: const Color(0xFF059669),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Stable Control',
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Latest HbA1c: 6.2%',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: darkText,
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
    );
  }

  Widget _buildRichTimelineItem({
    required Color dotColor,
    required String date,
    required String title,
    String? subtitle,
    Color? dateColor,
    Widget? customContent,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Dot
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200, width: 2),
              ),
              child: Icon(Icons.circle, size: 10.sp, color: dotColor),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: dateColor ?? greyLabel,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(fontSize: 12.sp, color: greyText),
                  ),
                ],
                if (customContent != null) customContent,
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

        // 🚨 INCREASED HEIGHT HERE TO FIX THE 2.7 PIXEL OVERFLOW 🚨
        SizedBox(
          height: 160.h, // Changed from 140.h to 160.h
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDocCard(
                icon: Icons.receipt_long_outlined,
                iconColor: const Color(0xFFEA580C),
                iconBg: const Color(0xFFFFF7ED),
                title: 'HbA1c Report',
                subtitle: 'Dec 12, 2024',
                actionText: 'VIEW REPORT',
                actionIcon: Icons.arrow_forward,
              ),
              SizedBox(width: 16.w),
              _buildDocCard(
                icon: Icons.picture_as_pdf_outlined,
                iconColor: const Color(0xFFEF4444), // Red
                iconBg: const Color(0xFFFEF2F2),
                title: 'Active Care Plan',
                subtitle: 'PDF • 2.4 MB',
                actionText: 'DOWNLOAD',
                actionIcon: Icons.download_outlined,
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
    required String actionText,
    required IconData actionIcon,
  }) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20.sp),
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
          SizedBox(height: 8.h),
          // Interactive Text at Bottom
          Row(
            children: [
              Text(
                actionText,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(actionIcon, size: 12.sp, color: primaryBlue),
            ],
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
      ),
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
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  color: PdfColors.blue600,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Type 2 Diabetes',
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
                  'Status: ACTIVE',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.orange600,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Divider(thickness: 1, color: PdfColors.grey300),
                pw.SizedBox(height: 24),
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
                  'Dr. Rakesh Kumar (Endocrinologist)',
                ),
                pw.SizedBox(height: 32),
                pw.Text(
                  'Condition Summary',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'A chronic condition that affects the way your body processes blood sugar. Requires consistent monitoring and lifestyle management.',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey800,
                    lineSpacing: 1.5,
                  ),
                ),
                pw.SizedBox(height: 32),
                pw.Text(
                  'Treatment Timeline',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                _buildPdfTimelineRow(
                  'Jan 05, 2024',
                  'Initial Diagnosis',
                  'Treatment plan: Metformin 500mg (1-0-1)',
                ),
                pw.SizedBox(height: 12),
                _buildPdfTimelineRow(
                  'Sep 10, 2024',
                  'Lab Review',
                  'Metabolic markers within stable range.',
                ),
                pw.SizedBox(height: 12),
                _buildPdfTimelineRow(
                  'Dec 12, 2024',
                  'Routine Check',
                  'Stable Control - Latest HbA1c: 6.2%',
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Diabetes_Type2_Summary.pdf',
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
          height: 300,
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
