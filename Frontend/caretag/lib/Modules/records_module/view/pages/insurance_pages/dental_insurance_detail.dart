import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DentalClaimScreen extends StatelessWidget {
  const DentalClaimScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF2563EB); // Deep Blue
  final Color darkText = const Color(0xFF111827);
  final Color greyLabel = const Color(0xFF9CA3AF);
  final Color greyText = const Color(0xFF6B7280);
  final Color successGreen = const Color(0xFF059669);
  final Color lightGreen = const Color(0xFFD1FAE5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Dental Claim',
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
          // 🚨 Share Button triggers PDF generation
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () => _downloadSettlementPdf(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. BLUE HEADER ---
            _buildBlueHeader(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 32.h),

                  // --- 2. STATUS SECTION ---
                  _buildStatusSection(),
                  SizedBox(height: 32.h),

                  // --- 3. FINANCIAL BREAKDOWN CARD ---
                  _buildFinancialBreakdownCard(),
                  SizedBox(height: 16.h),

                  // --- 4. PAYMENT SENT CARD ---
                  _buildPaymentSentCard(),
                  SizedBox(height: 16.h),

                  // --- 5. DOCUMENTS CARD ---
                  _buildDocumentsCard(context),
                  SizedBox(height: 32.h),

                  // --- 6. HELP LINK ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.help_outline, size: 14.sp, color: greyLabel),
                      SizedBox(width: 6.w),
                      Text(
                        'Need help with this claim?',
                        style: GoogleFonts.inter(
                          color: greyLabel,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
            // Note: Standard Flutter doesn't have a tooth icon, using a medical shield as a fallback
            child: Icon(
              Icons.health_and_safety_outlined,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),

          // Text Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dental Consultation',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Pari Clinic • Sep 15, 2024',
                  style: GoogleFonts.inter(
                    color: Colors.blue.shade100,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      children: [
        // Green Check Circle
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
          child: Icon(
            Icons.check_circle_outline,
            color: successGreen,
            size: 32.sp,
          ),
        ),
        SizedBox(height: 16.h),

        // Status Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5), // Very light green
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: lightGreen),
          ),
          child: Text(
            'SETTLED SUCCESSFULLY',
            style: GoogleFonts.inter(
              color: successGreen,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
              letterSpacing: 1.0,
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Subtext
        Text(
          'Your claim INS-3398 has been\nprocessed and settled.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: greyText,
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialBreakdownCard() {
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
          // Title
          Row(
            children: [
              Icon(Icons.payments_outlined, color: greyLabel, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'FINANCIAL BREAKDOWN',
                style: GoogleFonts.inter(
                  color: greyLabel,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Claimed Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Claimed Amount',
                style: GoogleFonts.inter(color: greyText, fontSize: 14.sp),
              ),
              Text(
                '₹1,500',
                style: GoogleFonts.inter(
                  color: darkText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Deductibles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deductibles',
                style: GoogleFonts.inter(color: greyText, fontSize: 14.sp),
              ),
              Text(
                '₹0',
                style: GoogleFonts.inter(
                  color: greyLabel,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Dotted Divider
          SizedBox(
            width: double.infinity,
            height: 1,
            child: CustomPaint(painter: DottedLinePainter()),
          ),
          SizedBox(height: 16.h),

          // Settled Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Settled Amount',
                style: GoogleFonts.inter(
                  color: darkText,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹1,500',
                style: GoogleFonts.inter(
                  color: successGreen,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSentCard() {
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_outlined,
              color: primaryBlue,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Sent',
                  style: GoogleFonts.inter(
                    color: darkText,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Paid to Bank Account (XXXX-4821)\nProcessed on Sep 18, 2024',
                  style: GoogleFonts.inter(
                    color: greyLabel,
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildDocumentsCard(BuildContext context) {
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
          Text(
            'Documents',
            style: GoogleFonts.inter(
              color: darkText,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),

          // Document Row
          InkWell(
            onTap: () =>
                _downloadSettlementPdf(context), // 🚨 Triggers PDF Download
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF2F2),
                    shape: BoxShape.circle,
                  ), // Light Red
                  child: Icon(
                    Icons.picture_as_pdf_outlined,
                    color: const Color(0xFFEF4444),
                    size: 24.sp,
                  ), // Red PDF icon
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settlement Letter',
                        style: GoogleFonts.inter(
                          color: darkText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'PDF • 1.2 MB',
                        style: GoogleFonts.inter(
                          color: greyLabel,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.download_outlined, color: greyLabel, size: 20.sp),
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

  Future<void> _downloadSettlementPdf(BuildContext context) async {
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
                  'OFFICIAL SETTLEMENT LETTER',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Claim ID: INS-3398',
                  style: const pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 24),

                pw.Text(
                  'Dental Consultation',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Pari Clinic • Sep 15, 2024',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 32),

                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.green50,
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'STATUS: SETTLED SUCCESSFULLY',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green800,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Your claim has been processed and the settled amount has been transferred to your registered bank account ending in XXXX-4821.',
                        style: const pw.TextStyle(color: PdfColors.green900),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 32),

                pw.Text(
                  'FINANCIAL BREAKDOWN',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.Divider(thickness: 1, color: PdfColors.grey300),
                pw.SizedBox(height: 16),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Claimed Amount',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'INR 1,500',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Deductibles',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'INR 0',
                      style: const pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),
                pw.Divider(thickness: 1, color: PdfColors.grey300),
                pw.SizedBox(height: 16),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Settled Amount',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'INR 1,500',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.green600,
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

    // Triggers native share/save dialog
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Settlement_Letter_INS3398.pdf',
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
