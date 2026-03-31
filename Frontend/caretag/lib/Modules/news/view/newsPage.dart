import 'package:caretag/Modules/news/model/newsmodel.dart';
import 'package:caretag/Modules/news/view/fitness_nutrition_content.dart';
import 'package:caretag/Modules/news/view/pages/alerts_safety_content.dart';
import 'package:caretag/Modules/news/view/pages/diseases_awareness_content.dart';
import 'package:caretag/Modules/news/view/pages/health_tips_content.dart';
import 'package:caretag/Modules/news/view/pages/medical_technology_content.dart';
import 'package:caretag/Modules/news/view/pages/medicines_treatments_content.dart';
import 'package:caretag/Modules/news/view/pages/mental_wellness_content.dart';
import 'package:caretag/Modules/news/view/widgets/FeatureNewsCard.dart';
import 'package:caretag/Modules/news/view/widgets/news_card.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  static const routeName = '/news';

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
          // Header section
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
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF111827),
                        ),
                        suffixIcon: const Icon(
                          Icons.tune, // Filter icon
                          color: Color(0xFF3B82F6),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Horizontal Scrollable Navbar
          SizedBox(
            height: 50,
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

          // Main Content Area
          Expanded(
            child: _selectedCategoryIndex == 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Featured Section
                        FeaturedNewsCard(
                          article: dummyNewsArticles.firstWhere(
                            (a) => a.isFeatured,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/news-detail',
                              arguments: {
                                'article': dummyNewsArticles.firstWhere(
                                  (a) => a.isFeatured,
                                ),
                              },
                            );
                          },
                        ),

                        // Latest Updates Title
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                          child: Text(
                            'Latest Updates',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),

                        // Other News Items
                        ...dummyNewsArticles
                            .where((a) => !a.isFeatured)
                            .map(
                              (article) => NewsCard(
                                article: article,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/news-detail',
                                    arguments: {'article': article},
                                  );
                                },
                              ),
                            ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                : _selectedCategoryIndex == 1
                ? const HealthTipsContent()
                : _selectedCategoryIndex == 2
                ? const DiseasesAwarenessContent()
                : _selectedCategoryIndex == 3
                ? const MedicinesTreatmentsContent()
                : _selectedCategoryIndex == 4
                ? const FitnessNutritionContent()
                : _selectedCategoryIndex == 7
                ? const AlertsSafetyContent()
                : _selectedCategoryIndex == 5
                ? const MentalWellnessContent()
                : _selectedCategoryIndex == 6
                ? const MedicalTechnologyContent()
                : Center(
                    child: Text(
                      '${_categories[_selectedCategoryIndex].replaceAll('\n', ' ')} Content Here',
                    ),
                  ),
          ),

          // Bottom Navigation Bar
        ],
      ),
    );
  }
}
