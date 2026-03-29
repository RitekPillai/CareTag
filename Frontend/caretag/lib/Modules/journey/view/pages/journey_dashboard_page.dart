import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyDashboardPage extends StatelessWidget {
  const JourneyDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Journey',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffff7a00),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Track your health and fitness journey',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),
                _buildStatsCard(
                  'Steps Today',
                  '8,542',
                  '12,000 goal',
                  Icons.directions_walk,
                  0.71,
                  const Color(0xffff7a00),
                ),
                const SizedBox(height: 15),
                _buildStatsCard(
                  'Calories Burned',
                  '420',
                  '600 goal',
                  Icons.local_fire_department,
                  0.70,
                  const Color(0xffFF6B6B),
                ),
                const SizedBox(height: 15),
                _buildStatsCard(
                  'Distance',
                  '5.2 km',
                  '8 km goal',
                  Icons.route,
                  0.65,
                  const Color(0xff4ECDC4),
                ),
                const SizedBox(height: 15),
                _buildStatsCard(
                  'Active Minutes',
                  '45 min',
                  '60 min goal',
                  Icons.timer,
                  0.75,
                  const Color(0xff95E1D3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(
    String title,
    String value,
    String goal,
    IconData icon,
    double progress,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: color,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  goal,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
