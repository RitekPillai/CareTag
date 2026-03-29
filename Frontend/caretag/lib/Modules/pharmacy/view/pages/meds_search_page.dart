import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedsSearchPage extends StatefulWidget {
  const MedsSearchPage({super.key});

  @override
  State<MedsSearchPage> createState() => _MedsSearchPageState();
}

class _MedsSearchPageState extends State<MedsSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                'Search Medicines',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff00c469),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for medicines, health products...',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xff00c469),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Popular Searches',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSearchChip('Paracetamol'),
                  _buildSearchChip('Vitamins'),
                  _buildSearchChip('First Aid'),
                  _buildSearchChip('Diabetes Care'),
                  _buildSearchChip('Pain Relief'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
      },
      child: Chip(
        label: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xff00c469),
          ),
        ),
        backgroundColor: const Color(0xff00c469).withOpacity(0.1),
        side: BorderSide.none,
      ),
    );
  }
}
