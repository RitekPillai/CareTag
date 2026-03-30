import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MedicalHistoryDetailScreen extends StatelessWidget {
  const MedicalHistoryDetailScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF1D4ED8); // Deep Blue
  final Color brightBlue = const Color(0xFF2563EB); // Bright Blue for buttons
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light grey
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Invoice Details', // Matching your design's app bar title
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

                  // 3. Patient & Physician Card
                  _buildPatientPhysicianCard(),
                  SizedBox(height: 20.h),

                  // 4. Condition Summary Card
                  _buildConditionSummaryCard(),
                  SizedBox(height: 20.h),

                  // 5. Treatment Timeline Card
                  _buildTreatmentTimelineCard(),
                  SizedBox(height: 24.h),

                  // 6. Linked Documents Section
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
        color: brightBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Acute Bronchitis',
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

  Widget _buildPatientPhysicianCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
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
      child: Column(
        children: [
          // Top Row: Patient & Date
          Row(
            children: [
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
                        Icon(
                          Icons.person_outline,
                          color: greyLabel,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Rylan Chettiar',
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                        Icon(
                          Icons.calendar_today_outlined,
                          color: brightBlue,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Oct 19, 2024',
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey.shade100, thickness: 1.5),
          SizedBox(height: 16.h),

          // Bottom Row: Treating Physician
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TREATING PHYSICIAN',
                      style: GoogleFonts.inter(
                        color: greyLabel,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF6FF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: brightBlue,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Sarah Wilson',
                                style: GoogleFonts.inter(
                                  color: darkText,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Pulmonologist • City Clinic',
                                style: GoogleFonts.inter(
                                  color: greyText,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: brightBlue, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Condition Summary',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              'Inflammation of the bronchial tubes. Characterized by persistent cough and chest congestion. Usually viral in origin, requiring symptomatic relief and rest.',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart, color: brightBlue, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Treatment Timeline',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ],
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
                    dotColor: brightBlue,
                    dotBg: const Color(0xFFEFF6FF),
                    date: 'Oct 19, 09:30 AM',
                    title: 'First Consultation',
                    subtitle: 'Physical examination and initial diagnosis.',
                  ),
                  _buildTimelineItem(
                    dotColor: const Color(0xFF9333EA), // Purple
                    dotBg: const Color(0xFFF3E8FF),
                    date: 'Oct 19, 10:15 AM',
                    title: 'Antibiotic Course Start',
                    subtitle: 'Azithromycin 500mg prescribed for 5 days.',
                  ),
                  _buildTimelineItem(
                    isCheck: true,
                    dotColor: const Color(0xFF059669), // Green
                    dotBg: const Color(0xFFD1FAE5),
                    date: 'Oct 24, 04:00 PM',
                    title: 'Recovery Confirmed',
                    subtitle: 'Symptoms subsided. Follow-up complete.',
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
    required Color dotBg,
    required String date,
    required String title,
    required String subtitle,
    bool isCheck = false,
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
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(color: dotBg, shape: BoxShape.circle),
              child: isCheck
                  ? Icon(Icons.check, size: 10.sp, color: dotColor)
                  : Icon(Icons.circle, size: 10.sp, color: dotColor),
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
          'LINKED DOCUMENTS',
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: greyLabel,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 130.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDocCard(
                icon: Icons.receipt_long_outlined,
                iconColor: const Color(0xFFEA580C),
                title: 'Prescription',
                subtitle: 'Oct 19 • PDF',
              ),
              SizedBox(width: 16.w),
              _buildDocCard(
                icon: Icons.monitor_heart_outlined,
                iconColor: brightBlue,
                title: 'Chest X-Ray',
                subtitle: 'Oct 19 • JPG',
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
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28.sp),
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
                  backgroundColor: brightBlue,
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
                        'Acute Bronchitis',
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
                    _buildPdfDataColumn('Patient Name', 'Rylan Chettiar'),
                    _buildPdfDataColumn('Date', 'Oct 19, 2024'),
                  ],
                ),
                pw.SizedBox(height: 20),
                _buildPdfDataColumn(
                  'Treating Physician',
                  'Dr. Sarah Wilson (Pulmonologist, City Clinic)',
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
                  'Inflammation of the bronchial tubes. Characterized by persistent cough and chest congestion. Usually viral in origin, requiring symptomatic relief and rest.',
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
                  'Oct 19, 09:30 AM',
                  'First Consultation',
                  'Physical examination and initial diagnosis.',
                ),
                pw.SizedBox(height: 12),
                _buildPdfTimelineRow(
                  'Oct 19, 10:15 AM',
                  'Antibiotic Course Start',
                  'Azithromycin 500mg prescribed for 5 days.',
                ),
                pw.SizedBox(height: 12),
                _buildPdfTimelineRow(
                  'Oct 24, 04:00 PM',
                  'Recovery Confirmed',
                  'Symptoms subsided. Follow-up complete.',
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Acute_Bronchitis_Summary.pdf',
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
