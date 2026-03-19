import 'package:caretag/Modules/Invoice/model_view/bloc/invoice_bloc.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/widgets/doctor_profile_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DoctorDetailPage extends StatelessWidget {
  const DoctorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color whitshColor = Color(0xffF1F5F9);
    const Color blueShadowColor = Color.fromRGBO(19, 127, 236, 0.1);
    const Color greyTextColor = Color(0xff64748B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocBuilder<DoctorDetailBloc, DoctorDetailState>(
          builder: (context, state) {
            if (state is MyDoctorDetailSuccess) {
              final doctorDetails = state.doctorDetails;
              final clinicLocation = LatLng(
                doctorDetails.lat,
                doctorDetails.longit,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: whitshColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.arrow_back_rounded),
                          Text(
                            "Doctor Profile",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: AppColor.darkishBlue,
                            ),
                          ),
                          const Icon(Icons.share_rounded),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 55.h),

                  Container(
                    width: 128.w,
                    height: 128.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999999.r),
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: -4,
                          color: AppColor.getShadowColor(0.1),
                        ),
                        BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 15,
                          spreadRadius: -3,
                          color: AppColor.getShadowColor(0.1),
                        ),
                        const BoxShadow(
                          offset: Offset.zero,
                          blurRadius: 0,
                          spreadRadius: 4,
                          color: blueShadowColor,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(doctorDetails.imgUrl),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    "Dr. ${doctorDetails.docName}",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.sp,
                      color: AppColor.darkishBlue,
                    ),
                  ),
                  Text(
                    doctorDetails.speclization,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightBlueTextColor2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${doctorDetails.exp} year Experince",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: greyTextColor,
                    ),
                  ),
                  SizedBox(height: 55.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DoctorProfileTile(
                        path: "star.svg",
                        title: "4.9",
                        discription: "${doctorDetails.links} Links",
                      ),
                      DoctorProfileTile(
                        path: "fee.svg",
                        title: doctorDetails.fees.toString(),
                        discription: "Consultation",
                      ),
                      DoctorProfileTile(
                        path: "tick.svg",
                        title: "${doctorDetails.exp} yrs",
                        discription: "Exp.",
                      ),
                    ],
                  ),
                  SizedBox(height: 29.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Doctor',
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: AppColor.darkishBlueTextColor,
                          ),
                        ),
                        SizedBox(height: 7.h),

                        Text(
                          doctorDetails.about,
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xff475569),
                          ),
                        ),
                        SizedBox(height: 24.75.h),

                        Text(
                          "Clinic Location",
                          style: GoogleFonts.manrope(
                            fontSize: 18.sp,
                            color: AppColor.darkishBlueTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Container(
                          width: 358.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffF1F5F9),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                              horizontal: 16.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColor.lightBlueSmallContainerColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 30,
                                    color: AppColor.lightBlueTextColor2,
                                  ),
                                ),
                                SizedBox(width: 16.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctorDetails.hospitalName,
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                          color: AppColor.darkishBlueTextColor,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        doctorDetails.address,
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: const Color(0xff64748B),
                                        ),
                                      ),
                                      SizedBox(height: 12.h),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: SizedBox(
                                          height: 170,
                                          width: double.infinity,
                                          child: FlutterMap(
                                            options: MapOptions(
                                              initialCenter: clinicLocation,
                                              initialZoom: 15.0,
                                              interactionOptions:
                                                  const InteractionOptions(
                                                    flags: InteractiveFlag.none,
                                                  ),
                                            ),
                                            children: [
                                              TileLayer(
                                                urlTemplate:
                                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                userAgentPackageName:
                                                    'com.caretag.app',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  customElevatedButton(
                    48.h,
                    double.infinity,
                    "Book Appointment",
                    20.sp,
                    FontWeight.w700,
                    () {},
                  ),

                  SizedBox(height: 40.h),
                ],
              );
            }
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
