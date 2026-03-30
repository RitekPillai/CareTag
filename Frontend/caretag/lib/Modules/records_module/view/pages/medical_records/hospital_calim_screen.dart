import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HospitalizationClaimScreen extends StatelessWidget {
  const HospitalizationClaimScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB); // Royal Blue
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF4B5563);
  final Color lightGreyBg = const Color(0xFFF8FAFC);

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
          'Hospitalization Claim',
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
          // Share icon in AppBar triggers PDF sharing
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () => _sharePdf(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            // --- 1. MAIN CERTIFICATE CARD ---
            _buildCertificateCard(),
            SizedBox(height: 20.h),

            // --- 2. FOOTER TEXT ---
            Text(
              'Generated securely on Oct 06, 2023 at 09:41 AM.\nValid for insurance claims processing only.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: greyLabel,
                fontSize: 11.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 32.h),

            // --- 3. BOTTOM BUTTONS ---
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () =>
                    _downloadPdf(context), // 🚨 Triggers PDF Download
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                icon: Icon(
                  Icons.download_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                label: Text(
                  'Download as PDF',
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
              child: ElevatedButton.icon(
                onPressed: () => _sharePdf(context), // 🚨 Triggers PDF Share
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6), // Light Grey
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                icon: Icon(
                  Icons.share_outlined,
                  color: const Color(0xFF374151),
                  size: 20.sp,
                ),
                label: Text(
                  'Share with Organization',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF374151),
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
  // CERTIFICATE CARD
  // ==========================================
  Widget _buildCertificateCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Accent Line
          Container(
            height: 6.h,
            width: double.infinity,
            color: const Color(0xFFDBEAFE), // Light blue accent
          ),

          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Paid Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Hospitalization Claim\nCertificate',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'PAID',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Patient Box
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: lightGreyBg,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: greyText,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PATIENT NAME',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: greyLabel,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Rylan Chettiar',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Data Grid
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Issued By',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: greyLabel,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.business_outlined,
                                color: primaryBlue,
                                size: 16.sp,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'City General\nHospital',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: darkText,
                                  ),
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
                            'Date of Admission',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: greyLabel,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Oct 05, 2023',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Claim ID',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: greyLabel,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'INS-9032',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF374151),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Coverage Type',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: greyLabel,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Inpatient Care',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Divider
                Divider(color: Colors.grey.shade100, thickness: 1.5),
                SizedBox(height: 20.h),

                // Description
                Text(
                  'DESCRIPTION',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: greyLabel,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Official summary of treatment and hospitalization costs for insurance reimbursement. This document certifies that all dues have been settled directly with the insurance provider.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: greyText,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.h),

                // Authorized Signatory Box
                CustomPaint(
                  painter: DashedRectPainter(
                    color: Colors.grey.shade300,
                    strokeWidth: 1.5,
                    radius: 16.r,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side: Signature
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AUTHORIZED SIGNATORY',
                              style: GoogleFonts.inter(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: greyLabel,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'A. Williams',
                              style: GoogleFonts.dancingScript(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: greyLabel,
                              ), // Cursive signature
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Dr. A. Williams, CMO',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),

                        // Right side: Digital Seal
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryBlue.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: primaryBlue,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.approval,
                                  color: primaryBlue,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'DIGITAL SEAL',
                              style: GoogleFonts.inter(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
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
          ),
        ],
      ),
    );
  }

  // ==========================================
  // PDF GENERATION LOGIC
  // ==========================================

  Future<void> _downloadPdf(BuildContext context) async {
    final pdf = await _generateClaimPdf();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Hospitalization_Claim_INS9032.pdf',
    );
  }

  Future<void> _sharePdf(BuildContext context) async {
    final pdf = await _generateClaimPdf();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Hospitalization_Claim_INS9032.pdf',
    );
  }

  Future<pw.Document> _generateClaimPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(32),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.blue200, width: 2),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'HOSPITALIZATION CLAIM CERTIFICATE',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue800,
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.blue600,
                        borderRadius: pw.BorderRadius.all(
                          pw.Radius.circular(12),
                        ),
                      ),
                      child: pw.Text(
                        'PAID',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 32),

                // Patient Box
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'PATIENT NAME',
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey600,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'Rylan Chettiar',
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 24),

                // Grid
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn('Issued By', 'City General Hospital'),
                    _pdfDataColumn('Date of Admission', 'Oct 05, 2023'),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn('Claim ID', 'INS-9032'),
                    _pdfDataColumn('Coverage Type', 'Inpatient Care'),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 20),

                // Description
                pw.Text(
                  'DESCRIPTION',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Official summary of treatment and hospitalization costs for insurance reimbursement. This document certifies that all dues have been settled directly with the insurance provider.',
                  style: const pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
                ),

                pw.Spacer(),

                // Signatory
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.grey400,
                      style: pw.BorderStyle.dashed,
                    ),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'AUTHORIZED SIGNATORY',
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey600,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            'A. Williams',
                            style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColors.grey600,
                              fontStyle: pw.FontStyle.italic,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'Dr. A. Williams, CMO',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Container(
                            width: 60,
                            height: 60,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(
                                color: PdfColors.blue600,
                                width: 2,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                'DIGITAL\nSEAL',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  color: PdfColors.blue600,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Generated securely on Oct 06, 2023 at 09:41 AM.\nValid for insurance claims processing only.',
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 8,
                      color: PdfColors.grey500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _pdfDataColumn(String label, String value) {
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
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
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
