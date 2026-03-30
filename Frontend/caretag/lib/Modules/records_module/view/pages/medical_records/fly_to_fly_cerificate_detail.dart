import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FitToFlyScreen extends StatelessWidget {
  const FitToFlyScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF1D4ED8); // Button Blue (Darker)
  final Color skyBlue = const Color(0xFF0284C7); // Header Accent Blue
  final Color headerBgBlue = const Color(0xFFF0F9FF); // Very light blue header
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
          'Fit-to-Fly Certificate',
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
          // Share icon in AppBar triggers sharing as well
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
            SizedBox(height: 32.h),

            // --- 2. BOTTOM BUTTONS ---
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () =>
                    _downloadPdf(context), // 🚨 Triggers PDF Download
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB), // Bright blue
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- TOP LIGHT BLUE SECTION ---
          Container(
            color: headerBgBlue,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Faint Globe Watermark
                Positioned(
                  right: -10.w,
                  top: -10.h,
                  child: Icon(
                    Icons.public,
                    size: 80.sp,
                    color: skyBlue.withOpacity(0.15),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0F2FE),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.flight_takeoff,
                        color: skyBlue,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0EA5E9),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'INTERNATIONAL',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Fit-to-Fly Certificate',
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: darkText,
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

          // --- BOTTOM WHITE SECTION ---
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Document Type & Valid Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DOCUMENT TYPE',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: greyLabel,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'International Travel\nMedical Clearance',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        border: Border.all(color: const Color(0xFF34D399)),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14.sp,
                            color: const Color(0xFF059669),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'VALID',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF059669),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Dotted Divider
                SizedBox(
                  width: double.infinity,
                  height: 1,
                  child: CustomPaint(painter: DottedLinePainter()),
                ),
                SizedBox(height: 20.h),

                // --- DATA GRID ---
                Row(
                  children: [
                    Expanded(
                      child: _buildDataBlock('PATIENT NAME', 'Rylan Chettiar'),
                    ),
                    Expanded(
                      child: _buildDataBlock('ISSUED BY', 'Dr. Mark Roe'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildDataBlock('ISSUE DATE', 'Nov 12, 2023'),
                    ),
                    Expanded(child: _buildDataBlock('EXPIRY DATE', 'Dec 2025')),
                  ],
                ),
                SizedBox(height: 24.h),

                // --- MEDICAL CERTIFICATION BOX ---
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // Very light greyish blue
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: skyBlue,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'MEDICAL CERTIFICATION',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '"This is to certify that the patient is medically stable and fit for long-haul air travel."',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF334155),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'M. Roe',
                              style: GoogleFonts.dancingScript(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF475569),
                              ), // Cursive signature
                            ),
                            Text(
                              'DIGITAL SIGNATURE',
                              style: GoogleFonts.inter(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: greyLabel,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // --- QR CODE VERIFICATION ---
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 90.w,
                        height: 90.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A), // Dark Navy/Black
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.qr_code_2,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Scan at airport terminal for rapid\nverification',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: greyLabel,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // PDF GENERATION LOGIC
  // ==========================================

  Future<void> _downloadPdf(BuildContext context) async {
    final pdf = await _generateCertificatePdf();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Fit_To_Fly_Rylan.pdf',
    );
  }

  Future<void> _sharePdf(BuildContext context) async {
    final pdf = await _generateCertificatePdf();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Fit_To_Fly_Rylan.pdf',
    );
  }

  // The visual layout of the PDF document
  Future<pw.Document> _generateCertificatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.blue200, width: 4),
            ),
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.lightBlue400,
                            borderRadius: const pw.BorderRadius.all(
                              pw.Radius.circular(12),
                            ),
                          ),
                          child: pw.Text(
                            'INTERNATIONAL CLEARANCE',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Fit-to-Fly Certificate',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue800,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.green100,
                        border: pw.Border.all(color: PdfColors.green400),
                        borderRadius: const pw.BorderRadius.all(
                          pw.Radius.circular(12),
                        ),
                      ),
                      child: pw.Text(
                        'VALID',
                        style: pw.TextStyle(
                          color: PdfColors.green800,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 32),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 32),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn('PATIENT NAME', 'Rylan Chettiar'),
                    _pdfDataColumn('ISSUED BY', 'Dr. Mark Roe'),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn('ISSUE DATE', 'Nov 12, 2023'),
                    _pdfDataColumn('EXPIRY DATE', 'Dec 2025'),
                  ],
                ),
                pw.SizedBox(height: 40),

                // Medical Certification Box
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(24),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'MEDICAL CERTIFICATION',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blueGrey600,
                        ),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text(
                        '"This is to certify that the patient is medically stable and fit for long-haul air travel."',
                        style: const pw.TextStyle(fontSize: 14),
                      ),
                      pw.SizedBox(height: 32),
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'M. Roe',
                              style: pw.TextStyle(
                                fontSize: 24,
                                color: PdfColors.blueGrey800,
                                fontStyle: pw.FontStyle.italic,
                              ),
                            ),
                            pw.Text(
                              'DIGITAL SIGNATURE',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.grey500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                pw.Spacer(),

                // QR Code
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    children: [
                      pw.BarcodeWidget(
                        data:
                            "Fit-to-Fly Verification - Rylan Chettiar - Valid until Dec 2025",
                        width: 80,
                        height: 80,
                        barcode: pw.Barcode.qrCode(),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Scan at airport terminal for rapid verification',
                        style: const pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey500,
                        ),
                      ),
                    ],
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
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// CUSTOM PAINTER FOR DOTTED LINE
// ==========================================
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 4;
    const double dashSpace = 4;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
