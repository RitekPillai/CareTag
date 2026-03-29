import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyGoalsPage extends StatelessWidget {
  const JourneyGoalsPage({super.key});

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
                'My Goals',
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
                    _buildGoalCard(
                      'Daily Steps',
                      '12,000 steps',
                      8542,
                      12000,
                      Icons.directions_walk,
                      const Color(0xffff7a00),
                    ),
                    const SizedBox(height: 15),
                    _buildGoalCard(
                      'Weekly Workout',
                      '5 days per week',
                      3,
                      5,
                      Icons.fitness_center,
                      const Color(0xffFF6B6B),
                    ),
                    const SizedBox(height: 15),
                    _buildGoalCard(
                      'Water Intake',
                      '8 glasses per day',
                      5,
                      8,
                      Icons.water_drop,
                      const Color(0xff4ECDC4),
                    ),
                    const SizedBox(height: 15),
                    _buildGoalCard(
                      'Sleep Duration',
                      '8 hours per night',
                      6,
                      8,
                      Icons.bedtime,
                      const Color(0xff95E1D3),
                    ),
                    const SizedBox(height: 15),
                    _buildGoalCard(
                      'Weight Goal',
                      'Lose 5 kg in 3 months',
                      2,
                      5,
                      Icons.monitor_weight,
                      const Color(0xffAA96DA),
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
          'New Goal',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildGoalCard(
    String title,
    String target,
    int current,
    int total,
    IconData icon,
    Color color,
  ) {
    double progress = current / total;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
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
                    Text(
                      target,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: color,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$current / $total',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
