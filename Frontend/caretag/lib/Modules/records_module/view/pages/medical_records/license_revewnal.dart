import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LicenseRenewalScreen extends StatelessWidget {
  const LicenseRenewalScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB);
  final Color purpleAccent = const Color(0xFF9333EA);
  final Color lightPurple = const Color(0xFFF3E8FF);
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF4B5563);

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
          'Fitness for License Renewal',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
          // Share icon triggers PDF sharing
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
              'This digital certificate is valid for 6 months from the date\nof issue. Verify authenticity via QR scan at any transport\noffice.',
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
                  backgroundColor: const Color(0xFFF3F4F6),
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
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // FAINT WATERMARK (Car Icon)
          Positioned(
            right: -20.w,
            top: 20.h,
            child: Icon(
              Icons.directions_car_filled,
              size: 160.sp,
              color: lightPurple.withOpacity(0.4),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER (Icon & Badge) ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: lightPurple,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.directions_car_outlined,
                            color: purpleAccent,
                            size: 28.sp,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_outlined,
                                size: 14.sp,
                                color: purpleAccent,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'VERIFIED',
                                style: GoogleFonts.inter(
                                  color: purpleAccent,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // --- TITLE ---
                    Text(
                      'Medical Fitness for License\nRenewal',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Official Certification of Physical & Mental\nAptitude',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: greyLabel,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // --- DATA GRID 1 ---
                    Row(
                      children: [
                        Expanded(
                          child: _buildDataBlock(
                            'PATIENT NAME',
                            'Rylan Chettiar',
                          ),
                        ),
                        Expanded(
                          child: _buildDataBlock(
                            'ISSUED BY',
                            'Medical Board of\nWellness',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Divider
                    Divider(color: Colors.grey.shade100, thickness: 1.5),
                    SizedBox(height: 20.h),

                    // --- DATA GRID 2 ---
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DATE OF EXAM',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: greyLabel,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 14.sp,
                                    color: greyLabel,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Aug 18, 2023',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: darkText,
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
                                'REFERENCE NO.',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: greyLabel,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Text(
                                    '#  ',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: greyLabel,
                                    ),
                                  ),
                                  Text(
                                    'DL-4421',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: darkText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // --- CLINICAL FINDINGS BOX ---
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF), // Light Blue
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.assignment_turned_in_outlined,
                                color: const Color(0xFF1D4ED8),
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'CLINICAL FINDINGS',
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1D4ED8),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            '"Visual acuity, reaction time, and physical mobility are within acceptable limits for motor vehicle operation."',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF334155),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // --- SIGNATURE & SEAL ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Signature
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Authorized Signature',
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: greyLabel,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Dr. A. Gupta',
                              style: GoogleFonts.dancingScript(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ), // Cursive signature
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Chief Medical Officer',
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: greyLabel,
                              ),
                            ),
                          ],
                        ),

                        // Seal
                        CustomPaint(
                          painter: DashedCirclePainter(
                            color: const Color(0xFFC084FC),
                            strokeWidth: 1.5,
                          ), // Purple dashed border
                          child: Container(
                            width: 70.w,
                            height: 70.w,
                            alignment: Alignment.center,
                            child: Text(
                              'APPROVED\nOFFICIAL',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFC084FC),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --- BOTTOM GRADIENT BORDER ---
              Container(
                height: 8.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF9333EA),
                      Color(0xFF2563EB),
                    ], // Purple to Blue
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: greyLabel,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: darkText,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // PDF GENERATION LOGIC
  // ==========================================

  Future<void> _downloadPdf(BuildContext context) async {
    final pdf = await _generatePdfDocument();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'License_Fitness_Certificate.pdf',
    );
  }

  Future<void> _sharePdf(BuildContext context) async {
    final pdf = await _generatePdfDocument();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'License_Fitness_Certificate.pdf',
    );
  }

  Future<pw.Document> _generatePdfDocument() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(32),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.purple300, width: 2),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'MEDICAL FITNESS FOR LICENSE RENEWAL',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.purple800,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Official Certification of Physical & Mental Aptitude',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.purple50,
                        borderRadius: pw.BorderRadius.all(
                          pw.Radius.circular(8),
                        ),
                      ),
                      child: pw.Text(
                        'VERIFIED',
                        style: pw.TextStyle(
                          color: PdfColors.purple600,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),

                // Grid 1
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn('PATIENT NAME', 'Rylan Chettiar'),
                    _pdfDataColumn('ISSUED BY', 'Medical Board of Wellness'),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 20),

                // Grid 2
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn('DATE OF EXAM', 'Aug 18, 2023'),
                    _pdfDataColumn('REFERENCE NO.', '# DL-4421'),
                  ],
                ),
                pw.SizedBox(height: 32),

                // Findings Box
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(20),
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'CLINICAL FINDINGS',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        '"Visual acuity, reaction time, and physical mobility are within acceptable limits for motor vehicle operation."',
                        style: const pw.TextStyle(
                          fontSize: 12,
                          lineSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.Spacer(),

                // Signatory
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Authorized Signature',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Dr. A. Gupta',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Chief Medical Officer',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      width: 70,
                      height: 70,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(
                          color: PdfColors.purple300,
                          style: pw.BorderStyle.dashed,
                          width: 2,
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'APPROVED\nOFFICIAL',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.purple500,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
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
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey600,
          ),
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
// NATIVE DASHED CIRCLE PAINTER
// ==========================================
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double circumference = 2 * pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final double sweepAngle = (dashWidth / circumference) * 2 * pi;
    final double spaceAngle = (dashSpace / circumference) * 2 * pi;

    double startAngle = 0;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle + spaceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
