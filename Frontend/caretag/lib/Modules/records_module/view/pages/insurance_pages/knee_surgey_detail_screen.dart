import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class KneeSurgeyDetailScreen extends StatelessWidget {
  const KneeSurgeyDetailScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB); // Bright Blue
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF6B7280);

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
          // 🚨 Share Button triggers PDF sharing
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () => _shareClaimDetails(context),
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
            // --- 1. MAIN CLAIM CARD ---
            _buildClaimDetailsCard(),

            SizedBox(height: 32.h),

            // --- 2. TIMELINE SECTION ---
            Text(
              'Timeline',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
            SizedBox(height: 24.h),
            _buildTimelineSection(),

            SizedBox(height: 32.h),

            // --- 3. BOTTOM LARGE BUTTONS ---
            Row(
              children: [
                Expanded(
                  child: _buildLargeActionButton(
                    icon: Icons.receipt_long_outlined,
                    label: 'View Hospital Bill',
                    onTap: () => _downloadHospitalBillPdf(
                      context,
                    ), // 🚨 Triggers Bill PDF
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildLargeActionButton(
                    icon: Icons.download_outlined,
                    label: 'Download Form',
                    onTap: () =>
                        _downloadClaimFormPdf(context), // 🚨 Triggers Form PDF
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // UI COMPONENTS
  // ==========================================

  Widget _buildClaimDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Knee Surgery',
                      style: GoogleFonts.inter(
                        color: darkText,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Apollo Hospital',
                      style: GoogleFonts.inter(
                        color: greyText,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: primaryBlue,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),

          // Data Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CLAIM AMOUNT',
                    style: GoogleFonts.inter(
                      color: greyLabel,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '₹1,20,000',
                    style: GoogleFonts.inter(
                      color: darkText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CLAIM ID',
                    style: GoogleFonts.inter(
                      color: greyLabel,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'INS-4421',
                    style: GoogleFonts.inter(
                      color: darkText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Status Badge
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB), // Light yellow/orange
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: const Color(0xFFD97706), size: 8.sp),
                SizedBox(width: 8.w),
                Text(
                  'IN REVIEW',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFB45309), // Dark Orange
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
    return Stack(
      children: [
        // Vertical Grey Line (stops before the last item)
        Positioned(
          left: 11.w,
          top: 10.h,
          bottom: 40.h,
          child: Container(width: 2.w, color: Colors.grey.shade200),
        ),

        // Timeline Events
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineItem(
              status: TimelineStatus.completed,
              title: 'Claim Filed',
              subtitle: 'Oct 24 • Completed',
            ),
            _buildTimelineItem(
              status: TimelineStatus.completed,
              title: 'Documents Verified',
              subtitle: 'Oct 26 • Completed',
            ),
            _buildTimelineItem(
              status: TimelineStatus.active,
              title: 'Medical Review',
              subtitle:
                  'Our experts are reviewing the surgical notes to verify coverage details.',
            ),
            _buildTimelineItem(
              status: TimelineStatus.pending,
              title: 'Final Approval',
              subtitle: 'Pending',
            ),
            _buildTimelineItem(
              status: TimelineStatus.pending,
              title: 'Payment Settlement',
              subtitle: 'Pending',
              isLast: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required TimelineStatus status,
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    bool isCompleted = status == TimelineStatus.completed;
    bool isActive = status == TimelineStatus.active;
    bool isPending = status == TimelineStatus.pending;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 32.h),
      child: Row(
        crossAxisAlignment: isActive
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // --- TIMELINE DOT ---
          Container(
            color: Colors.white, // Solid white cuts the grey line behind it
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: _buildTimelineDot(status),
          ),
          SizedBox(width: 16.w),

          // --- TIMELINE CONTENT ---
          Expanded(
            child: isActive
                ? // Active Card Layout
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'ACTIVE',
                                style: GoogleFonts.inter(
                                  color: primaryBlue,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            color: greyText,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  )
                : // Standard Layout (Completed/Pending)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: isPending ? Colors.grey.shade400 : darkText,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: isPending ? Colors.grey.shade300 : greyText,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot(TimelineStatus status) {
    if (status == TimelineStatus.completed) {
      return Container(
        padding: EdgeInsets.all(2.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_circle,
          size: 20.sp,
          color: const Color(0xFF10B981),
        ), // Green
      );
    } else if (status == TimelineStatus.active) {
      return Container(
        padding: EdgeInsets.all(6.w),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF6FF),
          shape: BoxShape.circle,
        ), // Light blue glow
        child: Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(color: primaryBlue, shape: BoxShape.circle),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(6.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
  }

  Widget _buildLargeActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // PDF & LOGIC
  // ==========================================

  Future<void> _shareClaimDetails(BuildContext context) async {
    // Generate a quick summary PDF to share
    final pdf = _createBasePdfDocument("Claim Summary: INS-4421");
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Claim_Summary_INS4421.pdf',
    );
  }

  Future<void> _downloadHospitalBillPdf(BuildContext context) async {
    final pdf = _createBasePdfDocument("Official Hospital Bill");
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Apollo_Hospital_Bill.pdf',
    );
  }

  Future<void> _downloadClaimFormPdf(BuildContext context) async {
    final pdf = _createBasePdfDocument("Insurance Claim Form");
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Claim_Form_INS4421.pdf',
    );
  }

  // Helper method to generate the PDF layout
  pw.Document _createBasePdfDocument(String documentTitle) {
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
                pw.Text(
                  documentTitle,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  'Knee Surgery',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Apollo Hospital',
                  style: const pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'CLAIM AMOUNT',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text(
                          'INR 1,20,000',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'CLAIM ID',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text(
                          'INS-4421',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 32),
                pw.Text(
                  'Current Status: IN REVIEW',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.orange600,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'The claim is currently undergoing Medical Review by our experts to verify coverage details against the surgical notes provided.',
                  style: const pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }
}

enum TimelineStatus { completed, active, pending }
