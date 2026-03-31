import 'package:caretag/Modules/doctor_details/model/doctor_filer_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/searchbloc/search_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/pages/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// 🔥 ADD YOUR SEARCH BLOC IMPORT HERE (Adjust path if needed)
// import 'package:caretag/Modules/search/bloc/search_bloc.dart';

class CategoriesView extends StatefulWidget {
  CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  // We completely removed the dispose() hack because the separate SearchBloc fixes the bug!

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Cardiology',
      'icon': Icons.favorite_border,
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEE2E2),
    },
    {
      'title': 'Dentistry',
      'icon': Icons.medical_services_outlined,
      'color': const Color(0xFF0EA5E9),
      'bgColor': const Color(0xFFE0F2FE),
    },
    {
      'title': 'ENT Specialist',
      'icon': Icons.hearing_outlined,
      'color': const Color(0xFFD97706),
      'bgColor': const Color(0xFFFEF3C7),
    },
    {
      'title': 'Gastroenterology',
      'icon': Icons.search,
      'color': const Color(0xFFF97316),
      'bgColor': const Color(0xFFFFEDD5),
    },
    {
      'title': 'General Physician',
      'icon': Icons.screen_lock_portrait_rounded,
      'color': const Color(0xFF3B82F6),
      'bgColor': const Color(0xFFDBEAFE),
    },
    {
      'title': 'Gynecology',
      'icon': Icons.female_outlined,
      'color': const Color(0xFFEC4899),
      'bgColor': const Color(0xFFFCE7F3),
    },
    {
      'title': 'Neurology',
      'icon': Icons.psychology_outlined,
      'color': const Color(0xFF6366F1),
      'bgColor': const Color(0xFFE0E7FF),
    },
    {
      'title': 'Oncology',
      'icon': Icons.menu_book_outlined,
      'color': const Color(0xFFA855F7),
      'bgColor': const Color(0xFFF3E8FF),
    },
    {
      'title': 'Ophthalmology',
      'icon': Icons.visibility_outlined,
      'color': const Color(0xFF14B8A6),
      'bgColor': const Color(0xFFCCFBF1),
    },
    {
      'title': 'Orthopedics',
      'icon': Icons.accessibility_new_outlined,
      'color': const Color(0xFF475569),
      'bgColor': const Color(0xFFF1F5F9),
    },
    {
      'title': 'Pediatrics',
      'icon': Icons.child_care_outlined,
      'color': const Color(0xFFCA8A04),
      'bgColor': const Color(0xFFFEF08A),
    },
    {
      'title': 'Physiotherapy',
      'icon': Icons.directions_run_outlined,
      'color': const Color(0xFF22C55E),
      'bgColor': const Color(0xFFDCFCE7),
    },
    {
      'title': 'Psychiatry',
      'icon': Icons.psychology_alt_outlined,
      'color': const Color(0xFFD946EF),
      'bgColor': const Color(0xFFFAE8FF),
    },
    {
      'title': 'Pulmonology',
      'icon': Icons.air_outlined,
      'color': const Color(0xFF0284C7),
      'bgColor': const Color(0xFFBAE6FD),
    },
    {
      'title': 'Urology',
      'icon': Icons.water_drop_outlined,
      'color': const Color(0xFFE11D48),
      'bgColor': const Color(0xFFFFE4E6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Categories',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search for doctor specialties...',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF9CA3AF),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    // 🔥 Changed to SearchBloc
                    context.read<SearchBloc>().add(
                      PerformSearch(
                        filter: DoctorFilterModel(searchKeyword: value.trim()),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchResultsPage(
                          queryTitle: "Search: '${value.trim()}'",
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          Divider(color: Colors.grey.shade100, thickness: 1.5),

          // --- GRID VIEW ---
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 24.h,
                childAspectRatio: 0.8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryItem(context, category);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    Map<String, dynamic> category,
  ) {
    return GestureDetector(
      onTap: () {
        final filter = DoctorFilterModel(specialization: category['title']);

        // 🔥 Changed to SearchBloc
        context.read<SearchBloc>().add(PerformSearch(filter: filter));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SearchResultsPage(queryTitle: category['title']),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: category['bgColor'],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                category['icon'],
                color: category['color'],
                size: 28.sp,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            category['title'],
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF374151),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
