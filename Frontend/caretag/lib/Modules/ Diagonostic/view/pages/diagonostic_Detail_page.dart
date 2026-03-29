import 'package:caretag/Modules/%20Diagonostic/model_view/bloc/diagonostic_bloc.dart';
import 'package:caretag/Modules/%20Diagonostic/view/widget/book_alert_dialog_box.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnosticDetailsScreen extends StatefulWidget {
  const DiagnosticDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosticDetailsScreen> createState() =>
      _DiagnosticDetailsScreenState();
}

class _DiagnosticDetailsScreenState extends State<DiagnosticDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagonosticBloc, DiagonosticState>(
      builder: (context, state) {
        if (state is DiagonosticDetailFetched) {
          debugPrint(
            "network image:${state.diagonosticDetailModel.profileImageUrl}",
          );

          final data = state.diagonosticDetailModel;

          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FB),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          '₹0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => showBookingDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Book a Sample',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data.profileImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.4),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.4),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 220),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.centerName,
                                      style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.darkishBlue,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD1FAE5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'OPEN NOW',
                                      style: TextStyle(
                                        color: Color(0xFF059669),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFF59E0B),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '4.9',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'TOP RATED',
                                      style: TextStyle(
                                        color: Color(0xFF2563EB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '1.2 km away',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Divider(
                                  color: Color(0xFFF3F4F6),
                                  thickness: 1.5,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildFeatureIcon(
                                    Icons.home_outlined,
                                    'Home Sample',
                                  ),
                                  _buildFeatureIcon(
                                    Icons.verified_outlined,
                                    'NABL Accredited',
                                  ),
                                  _buildFeatureIcon(
                                    Icons.workspace_premium_outlined,
                                    'ISO Certified',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'About Lab',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.aboutLab,
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Available Tests',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View all',
                                style: TextStyle(color: Color(0xFF2563EB)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        ListView.builder(
                          shrinkWrap:
                              true, // Crucial for using inside ScrollView
                          physics:
                              const NeverScrollableScrollPhysics(), // Let the main page handle scrolling
                          padding: EdgeInsets.zero,
                          itemCount: data.diagonosticTests.length,
                          itemBuilder: (context, index) {
                            return _buildTestCard(
                              data.diagonosticTests[index].title,
                              data.diagonosticTests[index].discription,
                              data.diagonosticTests[index].price.toString(),
                              const Color(0xFFFEE2E2), // Fixed Hex Color!
                              const Color(0xFFEF4444),
                              Icons.accessibility_new_rounded,
                            );
                          },
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          backgroundColor: Color(0xFFF8F9FB),
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
          ),
        );
      },
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF60A5FA), size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTestCard(
    String title,
    String subtitle,
    String price,
    Color bgColor,
    Color iconColor,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            // Formatting the price to look nice with the rupee symbol
            '₹$price',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
