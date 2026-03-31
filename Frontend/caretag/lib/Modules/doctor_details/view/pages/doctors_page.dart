import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/pages/doctor_detail_page.dart';
import 'package:caretag/Modules/doctor_details/view/pages/top_rated_doctors.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/mydoctor_container_tile.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/specialties_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  void initState() {
    super.initState();
    // Trigger the combined API call on load
    context.read<DoctorDetailBloc>().add(FetchDoctorDashboard());
  }

  @override
  Widget build(BuildContext context) {
    const Color darkTextColor = Color(0xff111418);

    return BlocBuilder<DoctorDetailBloc, DoctorDetailState>(
      builder: (context, state) {
        if (state is DoctorDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorState) {
          return const Center(child: Text("Something went wrong."));
        }

        if (state is DoctorDashboardLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // --- 1. MY DOCTORS HEADER ---
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

                // --- 2. MY DOCTORS HORIZONTAL LIST ---
                if (state.myDoctors.isEmpty)
                  const Center(child: Text("No linked Doctors"))
                else
                  SizedBox(
                    height: 208.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.myDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = state.myDoctors[index];
                        return MydoctorContainerTile(
                          getDoctorModel: doctor,
                          onTap: () {
                            context.read<DoctorDetailBloc>().add(
                              GetMyDoctorDetails(id: doctor.id),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DoctorDetailPage(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                SizedBox(height: 32.h),

                const SpecialtiesTile(),
                SizedBox(height: 32.h),

                NearbyDoctorsWidget(nearbyDoctors: state.nearbyDoctors),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
