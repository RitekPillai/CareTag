import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FluInvoice extends StatelessWidget {
  const FluInvoice({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF1D4ED8);
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
                color: const Color(0xFFD1FAE5),
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
            SizedBox(height: 12.h),
            Text(
              'Verified by Pari Clinic System',
              style: GoogleFonts.inter(color: greyText, fontSize: 13.sp),
            ),
            SizedBox(height: 24.h),

            // --- MAIN CARD ---
            _buildMainDetailsCard(),

            SizedBox(height: 32.h),

            // --- BOTTOM BUTTONS ---

            // 1. PDF DOWNLOAD BUTTON
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () => _generateAndDownloadPdf(
                  context,
                ), // 🚨 Triggers PDF generation
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
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

            // 2. SET REMINDER BUTTON
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: OutlinedButton.icon(
                onPressed: () {
                  // 🚨 Triggers the SnackBar
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
                            'Reminder set for Oct 15, 2024',
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
                  foregroundColor: const Color(0xFF2563EB),
                  side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: const Color(0xFF2563EB),
                  size: 20.sp,
                ),
                label: Text(
                  'Set Reminder for Next Year',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2563EB),
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
  // PDF GENERATION LOGIC
  // ==========================================
  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final pdf = pw.Document();

    // Build the PDF page layout
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
                pw.Text(
                  'Official Vaccination Record',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Verified by Pari Clinic System',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.Divider(thickness: 2, color: PdfColors.grey300),
                pw.SizedBox(height: 24),

                // Main Details
                pw.Text(
                  'ANNUAL SHOT',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.orange600,
                  ),
                ),
                pw.Text(
                  'Influenza (Flu)',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 24),

                // Data Grid
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPdfDataColumn('Patient Name', 'Rylan Chettiar'),
                    _buildPdfDataColumn('Administered On', 'Oct 15, 2023'),
                  ],
                ),
                pw.SizedBox(height: 20),
                _buildPdfDataColumn('Vaccine Type', 'Quadrivalent Flu Vaccine'),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPdfDataColumn('Manufacturer', 'Sanofi Pasteur'),
                    _buildPdfDataColumn('Dose Type', 'Annual'),
                  ],
                ),
                pw.SizedBox(height: 20),
                _buildPdfDataColumn('Issued By', 'Pari Clinic, Main Branch'),

                pw.SizedBox(height: 40),

                // Clinical Notes
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Clinical Notes',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Monitor for mild fever for 24 hours. Keep hydrated and rest if fatigue occurs.',
                        style: const pw.TextStyle(color: PdfColors.blue900),
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

    // Trigger the native share/save dialog with the generated PDF
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Vaccination_Record_Influenza.pdf',
    );
  }

  // Helper for PDF layout
  pw.Widget _buildPdfDataColumn(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  // ==========================================
  // UI CARD BUILDER
  // ==========================================
  Widget _buildMainDetailsCard() {
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
          Positioned(
            right: -20.w,
            top: 20.h,
            child: Icon(
              Icons.health_and_safety_outlined,
              size: 140.sp,
              color: const Color(0xFFFFF7ED).withOpacity(0.8),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ANNUAL SHOT',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFEA580C),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Influenza (Flu)',
                            style: GoogleFonts.inter(
                              color: darkText,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF7ED),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.vaccines_outlined,
                        color: const Color(0xFFF59E0B),
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBlock('Patient Name', 'Rylan Chettiar'),
                    ),
                    Expanded(
                      child: _buildInfoBlock('Administered On', 'Oct 15, 2023'),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 1,
                  child: CustomPaint(painter: DottedLinePainter()),
                ),
                SizedBox(height: 24.h),
                _buildInfoBlock('Vaccine Type', 'Quadrivalent Flu Vaccine'),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBlock('Manufacturer', 'Sanofi Pasteur'),
                    ),
                    Expanded(child: _buildInfoBlock('Dose Type', 'Annual')),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildInfoBlock('Issued By', 'Pari Clinic, Main Branch'),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.medical_information_outlined,
                            color: const Color(0xFF2563EB),
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Clinical Notes',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF1D4ED8),
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Monitor for mild fever for 24 hours. Keep hydrated and rest if fatigue occurs.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 13.sp,
                          height: 1.5,
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

  Widget _buildInfoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: greyLabel,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: darkText,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

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
