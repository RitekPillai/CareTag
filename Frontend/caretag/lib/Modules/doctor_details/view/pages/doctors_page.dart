import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/pages/doctor_detail_page.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/mydoctor_container_tile.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/specialties_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkTextColor = Color(0xff111418);
    const Color searchBarBackgroundColor = Color(0xffF6F7F8);
    const Color searchBarHintText = Color(0xff617589);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Doctors",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: darkTextColor,
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  "See All",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.lightBlueTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        BlocBuilder<DoctorDetailBloc, DoctorDetailState>(
          builder: (context, state) {
            if (state is DoctorDetailLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MyDoctorSuccess) {
              final mydoctors = state.myDoctors;
              if (state.myDoctors.isEmpty) {
                return Center(child: Text("No linked Doctors "));
              }
              return SizedBox(
                height: 208.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mydoctors.length,
                  itemBuilder: (context, index) {
                    return MydoctorContainerTile(
                      getDoctorModel: mydoctors[index],
                      onTap: () {
                        context.read<DoctorDetailBloc>().add(
                          GetMyDoctorDetails(
                            id: mydoctors[index].id.toDouble(),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(height: 32.h),
        SpecialtiesTile(),
      ],
    );
  }
}
