import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'Home',
    'Health\nTips',
    'Diseases\n& Awareness',
    'Medicines\n& Treatments',
    'Fitness\n& Nutrition',
    'Mental\nWellness',
    'Medical\nTechnology',
    'Alerts\n& Safety',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B82F6), // Blue background
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(280, 100),
                      bottomRight: Radius.elliptical(280, 100),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          'Health News',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Search Bar overlay
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: customSearchBar(),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      final isSelected = _selectedCategoryIndex == index;
                      final isHome = index == 0;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: isHome ? 12 : 24),
                              alignment: Alignment.center,
                              child: Text(
                                _categories[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isHome ? 16 : 13,
                                  height: 1.2,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF1E63F4)
                                      : const Color(0xFF111827),
                                ),
                              ),
                            ),
                            if (isHome)
                              Container(
                                height: 20,
                                width: 1,
                                margin: const EdgeInsets.only(right: 24),
                                color: const Color(0xFFD1D5DB),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFE5E7EB)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
