import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedsCategoriesPage extends StatelessWidget {
  const MedsCategoriesPage({super.key});

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
                'Categories',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff00c469),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.1,
                  children: [
                    _buildCategoryCard(
                      'Fever & Pain',
                      Icons.thermostat,
                      const Color(0xffFF6B6B),
                    ),
                    _buildCategoryCard(
                      'Diabetes Care',
                      Icons.favorite,
                      const Color(0xff4ECDC4),
                    ),
                    _buildCategoryCard(
                      'Skin Care',
                      Icons.spa,
                      const Color(0xffFFBE0B),
                    ),
                    _buildCategoryCard(
                      'Vitamins',
                      Icons.energy_savings_leaf,
                      const Color(0xff95E1D3),
                    ),
                    _buildCategoryCard(
                      'First Aid',
                      Icons.medical_services,
                      const Color(0xffF38181),
                    ),
                    _buildCategoryCard(
                      'Baby Care',
                      Icons.child_care,
                      const Color(0xffAA96DA),
                    ),
                    _buildCategoryCard(
                      'Personal Care',
                      Icons.person,
                      const Color(0xff00c469),
                    ),
                    _buildCategoryCard(
                      'Health Devices',
                      Icons.monitor_heart,
                      const Color(0xff5DA7DB),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: color,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
