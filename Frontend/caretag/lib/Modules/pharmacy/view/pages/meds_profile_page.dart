import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedsProfilePage extends StatelessWidget {
  const MedsProfilePage({super.key});

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
                  'Pharmacy Account',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff00c469),
                  ),
                ),
                const SizedBox(height: 30),
                _buildMenuItem(
                  icon: Icons.history,
                  title: 'Order History',
                  subtitle: 'View your past orders',
                ),
                _buildMenuItem(
                  icon: Icons.location_on,
                  title: 'Saved Addresses',
                  subtitle: 'Manage delivery addresses',
                ),
                _buildMenuItem(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  subtitle: 'Manage payment options',
                ),
                _buildMenuItem(
                  icon: Icons.local_offer,
                  title: 'Offers & Coupons',
                  subtitle: 'View available offers',
                ),
                _buildMenuItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Manage your preferences',
                ),
                _buildMenuItem(
                  icon: Icons.help,
                  title: 'Help & Support',
                  subtitle: 'Get help with your orders',
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: 'About',
                  subtitle: 'App version and info',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xff00c469).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xff00c469),
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
      ),
    );
  }
}
