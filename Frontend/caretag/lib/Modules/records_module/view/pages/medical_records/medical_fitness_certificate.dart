import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MedicalCertificateScreen extends StatelessWidget {
  const MedicalCertificateScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB); // Button Blue
  final Color tealAccent = const Color(0xFF10B981); // Top bar & Valid badge
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
          'Medical Fitness Certificate',
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
            // --- 1. CERTIFICATE CARD ---
            _buildCertificateCard(),
            SizedBox(height: 24.h),

            // --- 2. LEGAL INFO TEXT ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 18.sp, color: greyLabel),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'This digital certificate is a legally valid document under the Digital Health Records Act (2023). It can be verified by scanning the QR code in the full PDF version.',
                    style: GoogleFonts.inter(
                      color: greyText,
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),

            // --- 3. BOTTOM BUTTONS ---
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () => _downloadPdf(context), // Triggers PDF Download
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
                onPressed: () => _sharePdf(context), // Triggers PDF Share
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
      child: Stack(
        children: [
          // FAINT WATERMARK (Cross)
          Positioned(
            right: -20.w,
            top: 60.h,
            child: Icon(
              Icons.add_box,
              size: 180.sp,
              color: const Color(0xFFF3F4F6),
            ), // Very faint grey
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TEAL ACCENT BAR AT TOP
              Container(height: 8.h, width: double.infinity, color: tealAccent),

              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.medical_information_outlined,
                          color: tealAccent,
                          size: 32.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Medical Fitness\nCertificate',
                                style: GoogleFonts.inter(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: darkText,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'OFFICIAL DOCUMENT • MFC-2023-8921',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: greyLabel,
                                  letterSpacing: 0.5,
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
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 14.sp,
                                color: tealAccent,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'VALID',
                                style: GoogleFonts.inter(
                                  color: tealAccent,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // --- DATA GRID ---
                    Row(
                      children: [
                        Expanded(
                          child: _buildDataBlock(
                            'PATIENT NAME',
                            'Rylan Chettiar',
                            isDark: true,
                          ),
                        ),
                        Expanded(child: _buildDataBlock('REG NO', '#77284-A')),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDataBlock('ISSUE DATE', 'Oct 24, 2023'),
                        ),
                        Expanded(
                          child: _buildDataBlock(
                            'VALID UNTIL',
                            'Oct 24, 2024',
                            customColor: tealAccent,
                          ),
                        ), // Green text
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // --- QUOTE BOX ---
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Text(
                        '"The patient has been examined and is found fit for general employment and physical activity."',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF4B5563),
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // --- SIGNATURE & STAMP ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Signature Block
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sarah Jenkins',
                              style: GoogleFonts.dancingScript(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
                              ), // Cursive signature
                            ),
                            Container(
                              height: 1,
                              width: 120.w,
                              color: Colors.grey.shade300,
                              margin: EdgeInsets.only(bottom: 8.h),
                            ),
                            Text(
                              'Dr. Sarah Jenkins',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: darkText,
                              ),
                            ),
                            Text(
                              'General Physician',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: greyText,
                              ),
                            ),
                          ],
                        ),

                        // Fake Circular Stamp
                        Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF818CF8),
                              width: 1.5,
                            ), // Indigo border
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CITY MEDICAL\nCENTER',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 6.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF818CF8),
                                ),
                              ),
                              Icon(
                                Icons.verified,
                                size: 14.sp,
                                color: const Color(0xFF818CF8),
                              ),
                              Text(
                                'APP - OK',
                                style: GoogleFonts.inter(
                                  fontSize: 5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF818CF8),
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

              // --- FOOTER ---
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID: 9928-1120-MED',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: greyLabel,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.lock_outline, size: 14.sp, color: greyLabel),
                        SizedBox(width: 4.w),
                        Text(
                          'Secure',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: greyLabel,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataBlock(
    String label,
    String value, {
    bool isDark = false,
    Color? customColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: greyLabel,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: isDark || customColor != null
                ? FontWeight.bold
                : FontWeight.w600,
            color: customColor ?? (isDark ? darkText : greyText),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // PDF GENERATION LOGIC
  // ==========================================

  // For downloading (saving locally)
  Future<void> _downloadPdf(BuildContext context) async {
    final pdf = await _generateCertificatePdf();
    // Using sharePdf for both as it handles iOS/Android file saving dialogues perfectly
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Medical_Fitness_Certificate_Rylan.pdf',
    );
  }

  // For sharing (sending to other apps)
  Future<void> _sharePdf(BuildContext context) async {
    final pdf = await _generateCertificatePdf();
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Medical_Fitness_Certificate_Rylan.pdf',
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
              border: pw.Border.all(color: PdfColors.teal500, width: 4),
            ),
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'MEDICAL FITNESS CERTIFICATE',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.teal800,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'OFFICIAL DOCUMENT • MFC-2023-8921',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
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
                pw.SizedBox(height: 40),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn(
                      'PATIENT NAME',
                      'Rylan Chettiar',
                      PdfColors.black,
                    ),
                    _pdfDataColumn('REG NO', '#77284-A', PdfColors.grey800),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _pdfDataColumn(
                      'ISSUE DATE',
                      'Oct 24, 2023',
                      PdfColors.grey800,
                    ),
                    _pdfDataColumn(
                      'VALID UNTIL',
                      'Oct 24, 2024',
                      PdfColors.teal700,
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),

                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(24),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                  ),
                  child: pw.Text(
                    '"The patient has been examined and is found fit for general employment and physical activity."',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                ),

                pw.Spacer(),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Sarah Jenkins',
                          style: pw.TextStyle(
                            fontSize: 24,
                            color: PdfColors.blue800,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ), // Mock cursive
                        pw.Container(
                          height: 1,
                          width: 150,
                          color: PdfColors.grey400,
                          margin: const pw.EdgeInsets.only(top: 4, bottom: 8),
                        ),
                        pw.Text(
                          'Dr. Sarah Jenkins',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'General Physician',
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),

                    pw.Container(
                      width: 80,
                      height: 80,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(
                          color: PdfColors.indigo400,
                          width: 2,
                        ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          'CITY MEDICAL\nCENTER\n\nVERIFIED',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.indigo400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'ID: 9928-1120-MED',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey500,
                      ),
                    ),
                    pw.Text(
                      'Securely Generated by CareTag System',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey500,
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

  pw.Widget _pdfDataColumn(String label, String value, PdfColor valueColor) {
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
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
