import 'package:caretag/Modules/doctor_details/model/specialties_option_model.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/specialties_options_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialtiesTile extends StatelessWidget {
  const SpecialtiesTile({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkTextColor = Color(0xff111418);
    List<SpecialtiesOptionModel> specialtionList = [
      SpecialtiesOptionModel(
        containerColor: Color(0xffFFE4E6),
        title: "Heart",
        imagePath: "/heart.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffDBEAFE),
        title: "Dental",
        imagePath: "/dentist.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffD1FAE5),
        title: "Eye",
        imagePath: "/eye.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffF3E8FF),
        title: "Brain",
        imagePath: "/neuro.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffFFEDD5),
        title: "Bones",
        imagePath: "/bone.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffFEF9C3),
        title: "Kids",
        imagePath: "/kids.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffCCFBF1),
        title: "Mental",
        imagePath: "/brain.svg",
      ),
      SpecialtiesOptionModel(
        containerColor: Color(0xffF3F4F6),
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
                  onPressed: () {},
                  child: Text(
                    "See All",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff137FEC),
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
              return SpecialtiesOptionsTile(
                containerColor: specialtionList[index].containerColor,
                title: specialtionList[index].title,
                imagePath: specialtionList[index].imagePath,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rated Nearby",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: darkTextColor,
                  ),
                ),

                SvgPicture.asset("assets/images/mycare/mydoctor/settings.svg"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
