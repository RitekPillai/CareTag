import 'package:caretag/Modules/doctor_details/model/doctor_filer_model.dart';
import 'package:caretag/Modules/doctor_details/model/specialties_option_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/searchbloc/search_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/pages/categories_view.dart';
import 'package:caretag/Modules/doctor_details/view/pages/search_result_page.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/specialties_options_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// 🔥 IMPORT YOUR SEARCH BLOC, MODEL, AND RESULTS PAGE HERE
// import 'package:caretag/Modules/search/bloc/search_bloc.dart';
// import 'package:caretag/Modules/search/model/doctor_filter_model.dart';
// import 'package:caretag/Modules/doctor_details/view/pages/search_result_page.dart';

class SpecialtiesTile extends StatelessWidget {
  const SpecialtiesTile({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkTextColor = Color(0xff111418);
    List<SpecialtiesOptionModel> specialtionList = [
      SpecialtiesOptionModel(
        containerColor: const Color(0xffFFE4E6),
        title: "Heart",
        imagePath: "/heart.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffDBEAFE),
        title: "Dental",
        imagePath: "/dentist.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffD1FAE5),
        title: "Eye",
        imagePath: "/eye.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffF3E8FF),
        title: "Brain",
        imagePath: "/neuro.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffFFEDD5),
        title: "Bones",
        imagePath: "/bone.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffFEF9C3),
        title: "Kids",
        imagePath: "/kids.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffCCFBF1),
        title: "Mental",
        imagePath: "/brain.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: const Color(0xffF3F4F6),
        title: "More",
        imagePath: "/more.svg",
      ),
    ];

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Specialties",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Just a clean push, no more .then() hack needed!
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoriesView()),
                    );
                  },
                  child: Text(
                    "See All",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff137FEC),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: specialtionList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              mainAxisExtent: 110,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final item = specialtionList[index];

              return GestureDetector(
                onTap: () {
                  if (item.title == "More") {
                    // Navigate to See All Categories
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoriesView()),
                    );
                  } else {
                    // Map the simple UI titles to actual database specialties if needed
                    // E.g., "Heart" -> "Cardiology", "Kids" -> "Pediatrics"
                    String searchSpecialty = item.title;
                    if (item.title == "Heart") searchSpecialty = "Cardiology";
                    if (item.title == "Dental") searchSpecialty = "Dentistry";
                    if (item.title == "Eye") searchSpecialty = "Ophthalmology";
                    if (item.title == "Brain") searchSpecialty = "Neurology";
                    if (item.title == "Bones") searchSpecialty = "Orthopedics";
                    if (item.title == "Kids") searchSpecialty = "Pediatrics";
                    if (item.title == "Mental") searchSpecialty = "Psychiatry";

                    // Trigger the Search BLoC
                    final filter = DoctorFilterModel(
                      specialization: searchSpecialty,
                    );
                    context.read<SearchBloc>().add(
                      PerformSearch(filter: filter),
                    );

                    // Navigate to Search Results
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SearchResultsPage(queryTitle: item.title),
                      ),
                    );
                  }
                },
                child: SpecialtiesOptionsTile(
                  containerColor: item.containerColor,
                  title: item.title,
                  imagePath: item.imagePath,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
