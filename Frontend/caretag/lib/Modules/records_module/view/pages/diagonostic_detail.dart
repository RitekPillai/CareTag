import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalReportScreen extends StatelessWidget {
  const MedicalReportScreen({Key? key}) : super(key: key);

  final Color primaryBlue = const Color(0xFF3B82F6);
  final Color darkText = const Color(0xFF111827);
  final Color lightText = const Color(0xFF6B7280);
  final Color greenAccent = const Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Floating Bottom Action Area
      bottomNavigationBar: _buildBottomActionArea(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // Adding bottom padding so the floating buttons don't cover the last result
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 20),
              _buildAIAnalysisCard(),
              const SizedBox(height: 24),
              _buildTestResultsHeader(),
              const SizedBox(height: 16),
              _buildTestResultCard(
                title: 'Hemoglobin',
                value: '14.5',
                unit: 'g/dL',
                refRange: 'Ref: 13.0 - 17.0 g/dL',
                status: 'NORMAL',
                isNormal: true,
                minRef: 13.0,
                maxRef: 17.0,
                currentValue: 14.5,
              ),
              const SizedBox(height: 16),
              _buildTestResultCard(
                title: 'WBC Count',
                value: '7.2',
                unit: 'x10³/µL',
                refRange: 'Ref: 4.5 - 11.0 x10³/µL',
                status: 'NORMAL',
                isNormal: true,
                minRef: 4.5,
                maxRef: 11.0,
                currentValue: 7.2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // UI BUILDER METHODS
  // ==========================================

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'CBC / Hemogram',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5), // Light green tint
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified, color: greenAccent, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'VERIFIED',
                      style: GoogleFonts.inter(
                        color: greenAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Whole Blood',
            style: GoogleFonts.inter(fontSize: 14, color: lightText),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade100, thickness: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.business_outlined, size: 16, color: lightText),
              const SizedBox(width: 6),
              Text(
                'Pari Clinic',
                style: GoogleFonts.inter(fontSize: 13, color: lightText),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('•', style: TextStyle(color: Colors.grey.shade300)),
              ),
              Icon(Icons.calendar_today_outlined, size: 16, color: lightText),
              const SizedBox(width: 6),
              Text(
                '30 Feb 2025', // Note: Date from the image design
                style: GoogleFonts.inter(fontSize: 13, color: lightText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFEFF6FF), // Very light blue
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDBEAFE)), // Light blue border
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.auto_awesome, color: primaryBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI ANALYSIS',
                  style: GoogleFonts.inter(
                    color: primaryBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your hemoglobin and red blood cell counts are healthy. Your immune system markers are within optimal ranges.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4B5563),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResultsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Test Results',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
        Text(
          '4 Parameters',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildTestResultCard({
    required String title,
    required String value,
    required String unit,
    required String refRange,
    required String status,
    required bool isNormal,
    required double minRef,
    required double maxRef,
    required double currentValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: lightText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Custom Slider Visualization
          SizedBox(
            height: 12,
            width: double.infinity,
            child: CustomPaint(
              painter: RangeSliderPainter(
                minRef: minRef,
                maxRef: maxRef,
                currentValue: currentValue,
                // Assuming absolute min is 0, and absolute max is roughly 1.5x the maxRef for visualization bounds
                absoluteMin: 0,
                absoluteMax: maxRef * 1.5,
                normalColor: const Color(0xFF86EFAC), // Soft green
                indicatorColor: greenAccent,
                trackColor: Colors.grey.shade100,
              ),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                refRange,
                style: GoogleFonts.inter(fontSize: 12, color: lightText),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isNormal
                      ? const Color(0xFFECFDF5)
                      : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    color: isNormal ? greenAccent : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionArea() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.file_download_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Download Original PDF',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Consult a Doctor',
                style: GoogleFonts.inter(
                  color: primaryBlue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// CUSTOM PAINTER FOR THE NORMAL RANGE BAR
// ==========================================

class RangeSliderPainter extends CustomPainter {
  final double minRef;
  final double maxRef;
  final double currentValue;
  final double absoluteMin;
  final double absoluteMax;
  final Color normalColor;
  final Color indicatorColor;
  final Color trackColor;

  RangeSliderPainter({
    required this.minRef,
    required this.maxRef,
    required this.currentValue,
    required this.absoluteMin,
    required this.absoluteMax,
    required this.normalColor,
    required this.indicatorColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final normalRangePaint = Paint()
      ..color = normalColor
      ..style = PaintingStyle.fill;

    final indicatorPaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    // 1. Draw the background track (the full grey bar)
    final trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, size.height / 2 - 3, size.width, 6),
      const Radius.circular(3),
    );
    canvas.drawRRect(trackRect, trackPaint);

    // Calculate positions based on percentages
    final rangeWidth = absoluteMax - absoluteMin;
    final minRefPercent = (minRef - absoluteMin) / rangeWidth;
    final maxRefPercent = (maxRef - absoluteMin) / rangeWidth;
    final currentPercent = (currentValue - absoluteMin) / rangeWidth;

    // 2. Draw the normal range highlight (the light green block)
    final normalStartX = size.width * minRefPercent;
    final normalEndX = size.width * maxRefPercent;

    // Draw the green rectangle directly over the grey track
    final normalRect = Rect.fromLTWH(
      normalStartX,
      size.height / 2 - 3,
      normalEndX - normalStartX,
      6,
    );
    canvas.drawRect(normalRect, normalRangePaint);

    // 3. Draw the current value indicator (the dark green circle)
    final currentX = size.width * currentPercent;

    // Ensure the circle doesn't draw outside the canvas bounds
    final clampedX = currentX.clamp(4.0, size.width - 4.0);

    canvas.drawCircle(
      Offset(clampedX, size.height / 2),
      5, // Radius of the dot
      indicatorPaint,
    );

    // Add a tiny white border to the circle to make it pop against the bar
    canvas.drawCircle(
      Offset(clampedX, size.height / 2),
      5,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant RangeSliderPainter oldDelegate) {
    return oldDelegate.currentValue != currentValue ||
        oldDelegate.minRef != minRef ||
        oldDelegate.maxRef != maxRef;
  }
}
