import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyActivityPage extends StatelessWidget {
  const JourneyActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activity Log',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffff7a00),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildActivityCard(
                      'Morning Walk',
                      '6:30 AM - 7:15 AM',
                      '45 min',
                      '3.2 km',
                      '180 cal',
                      Icons.directions_walk,
                      const Color(0xff4ECDC4),
                    ),
                    const SizedBox(height: 12),
                    _buildActivityCard(
                      'Yoga Session',
                      '8:00 AM - 8:30 AM',
                      '30 min',
                      '-',
                      '120 cal',
                      Icons.self_improvement,
                      const Color(0xff95E1D3),
                    ),
                    const SizedBox(height: 12),
                    _buildActivityCard(
                      'Cycling',
                      '5:00 PM - 5:45 PM',
                      '45 min',
                      '8.5 km',
                      '250 cal',
                      Icons.directions_bike,
                      const Color(0xffff7a00),
                    ),
                    const SizedBox(height: 12),
                    _buildActivityCard(
                      'Gym Workout',
                      'Yesterday 6:00 PM',
                      '60 min',
                      '-',
                      '350 cal',
                      Icons.fitness_center,
                      const Color(0xffFF6B6B),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xffff7a00),
        icon: const Icon(Icons.add),
        label: Text(
          'Log Activity',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String time,
    String duration,
    String distance,
    String calories,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
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
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildStatChip(Icons.timer_outlined, duration),
                    const SizedBox(width: 10),
                    if (distance != '-')
                      _buildStatChip(Icons.route, distance),
                    if (distance != '-') const SizedBox(width: 10),
                    _buildStatChip(Icons.local_fire_department, calories),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
