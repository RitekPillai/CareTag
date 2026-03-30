import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class VaccinationBoosterScreen extends StatelessWidget {
  const VaccinationBoosterScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB); // Bright Blue
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light grey/white
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
            // --- TOP STATUS SECTION ---
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5), // Light green background
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
                  SizedBox(width: 6.w),
                  Text(
                    'COMPLETED',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF059669),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // --- 1. MAIN VACCINE DETAILS CARD ---
            _buildVaccineDetailsCard(),

            SizedBox(height: 20.h),

            // --- 2. QR CODE VERIFICATION CARD ---
            _buildQRCodeCard(),

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
                  // 🚨 SnackBar Reminder Trigger
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
  // VACCINE DETAILS CARD
  // ==========================================
  Widget _buildVaccineDetailsCard() {
    return Container(
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
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // FAINT WATERMARK
          Positioned(
            right: -30.w,
            top: 20.h,
            child: Icon(
              Icons.coronavirus_outlined,
              size: 160.sp,
              color: const Color(0xFFEFF6FF).withOpacity(0.8), // Faint Blue
            ),
          ),

          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VACCINE NAME',
                            style: GoogleFonts.inter(
                              color: greyLabel,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'COVID-19 Booster',
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Pfizer-BioNTech',
                            style: GoogleFonts.inter(
                              color: primaryBlue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
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
                        Icons.vaccines_outlined,
                        color: primaryBlue,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Data Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBlock('PATIENT NAME', 'Rylan Chettiar'),
                    ),
                    Expanded(child: _buildInfoBlock('BLOOD GROUP', 'O+')),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(child: _buildInfoBlock('DOSE', '3 of 3')),
                    Expanded(
                      child: _buildInfoBlock('BATCH NUMBER', 'PF-90210'),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Issued By Box
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB), // Grey box
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.business_outlined,
                          color: greyLabel,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Issued by',
                              style: GoogleFonts.inter(
                                color: greyLabel,
                                fontSize: 11.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'City Hospital',
                              style: GoogleFonts.inter(
                                color: darkText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Date',
                            style: GoogleFonts.inter(
                              color: greyLabel,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Feb 12, 2024',
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontSize: 14.sp,
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
          ),
        ],
      ),
    );
  }

  // ==========================================
  // QR CODE CARD
  // ==========================================
  Widget _buildQRCodeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
          // Mock QR Code using standard Icon
          Icon(Icons.qr_code_2, size: 120.sp, color: Colors.black87),
          SizedBox(height: 16.h),
          Text(
            'Scan to verify',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This QR code contains the digital signature for\ninstant verification.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: greyText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: greyLabel,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: darkText,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
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
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Official Vaccination Record',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Status: COMPLETED',
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.green600,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Divider(thickness: 2, color: PdfColors.grey300),
                pw.SizedBox(height: 24),

                pw.Text(
                  'VACCINE NAME',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                ),
                pw.Text(
                  'COVID-19 Booster',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Pfizer-BioNTech',
                  style: pw.TextStyle(fontSize: 16, color: PdfColors.blue600),
                ),
                pw.SizedBox(height: 24),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPdfDataColumn('PATIENT NAME', 'Rylan Chettiar'),
                    _buildPdfDataColumn('BLOOD GROUP', 'O+'),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPdfDataColumn('DOSE', '3 of 3'),
                    _buildPdfDataColumn('BATCH NUMBER', 'PF-90210'),
                  ],
                ),
                pw.SizedBox(height: 32),

                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
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
                            'Issued by',
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.grey600,
                            ),
                          ),
                          pw.Text(
                            'City Hospital',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Date',
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.grey600,
                            ),
                          ),
                          pw.Text(
                            'Feb 12, 2024',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 40),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.BarcodeWidget(
                    data: "COVID-19 Booster - Rylan Chettiar - VERIFIED",
                    width: 100,
                    height: 100,
                    barcode: pw.Barcode.qrCode(),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Scan to verify digital signature',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'COVID19_Booster_Record.pdf',
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
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }
}
