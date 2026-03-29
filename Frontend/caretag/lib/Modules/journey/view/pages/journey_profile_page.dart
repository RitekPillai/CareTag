import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyProfilePage extends StatelessWidget {
  const JourneyProfilePage({super.key});

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
                  'Fitness Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffff7a00),
                  ),
                ),
                const SizedBox(height: 30),
                _buildSection('Personal Info'),
                _buildMenuItem(
                  icon: Icons.cake,
                  title: 'Age',
                  value: '28 years',
                ),
                _buildMenuItem(
                  icon: Icons.height,
                  title: 'Height',
                  value: '175 cm',
                ),
                _buildMenuItem(
                  icon: Icons.monitor_weight,
                  title: 'Weight',
                  value: '70 kg',
                ),
                const SizedBox(height: 20),
                _buildSection('Settings'),
                _buildMenuItem(
                  icon: Icons.sync,
                  title: 'Sync Devices',
                  value: '',
                ),
                _buildMenuItem(
                  icon: Icons.notifications,
                  title: 'Reminder',
                  value: 'Daily at 6:00 AM',
                ),
                _buildMenuItem(
                  icon: Icons.language,
                  title: 'Units',
                  value: 'Metric',
                ),
                const SizedBox(height: 20),
                _buildSection('Privacy & Data'),
                _buildMenuItem(
                  icon: Icons.security,
                  title: 'Privacy Settings',
                  value: '',
                ),
                _buildMenuItem(
                  icon: Icons.download,
                  title: 'Export Data',
                  value: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: const Color(0xffff7a00),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xffff7a00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xffff7a00),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: value.isNotEmpty
            ? Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              )
            : const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
      ),
    );
  }
}
