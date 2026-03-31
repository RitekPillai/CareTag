import 'package:caretag/Modules/%20Diagonostic/model_view/bloc/diagonostic_bloc.dart';
import 'package:caretag/Modules/MyCare/view/pages/hospitallistpage.dart';
import 'package:caretag/Modules/MyCare/view/widgets/digonissi_nearby_tie.dart';
// import 'package:caretag/Modules/MyCare/view/widgets/hospital_nearby_tile.dart'; // We don't need this placeholder anymore
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// 🔥 IMPORT HOSPITAL BLOC & MODEL
import 'package:caretag/Modules/Hospital/model/NearByHospitalModel.dart';
import 'package:caretag/Modules/Hospital/model_view/bloc/bloc.dart';

// ... [Keep all your existing CsHospital, CsDoctor, CsDiagnostics classes and sample data here] ...
// (I have omitted them in this snippet to save space, but DO NOT delete them from your file!)

class MyCareCareServicesContent extends StatefulWidget {
  const MyCareCareServicesContent({super.key});

  @override
  State<MyCareCareServicesContent> createState() =>
      _MyCareCareServicesContentState();
}

class _MyCareCareServicesContentState extends State<MyCareCareServicesContent> {
  @override
  void initState() {
    super.initState();
    debugPrint("called");

    // Fetch Diagnostics
    context.read<DiagonosticBloc>().add(GetDiagnosticList());

    // 🔥 Fetch Hospitals for the preview list
    context.read<HospitalBloc>().add(FetchNearbyHospitals());
  }

  Future<void> handleEmergencyCall(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '108');
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This device does not support making phone calls.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open dialer: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color redColor = Color(0xffEF4444);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- EMERGENCY HELP SECTION ---
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99999.r),
                    color: redColor,
                  ),
                ),
                SizedBox(width: 7.w),
                Text(
                  "Emergency Help",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: const Color(0xff111817),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Emergency Card
            Container(
              width: 358.w,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: const Color(0xffFEF2F2),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFFFECACA)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: AppColor.getShadowColor(0.05),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 210.w,
                        child: Opacity(
                          opacity: 0.2,
                          child: SvgPicture.asset(
                            "assets/images/mycare/alram.svg",
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  color: AppColor.getShadowColor(0.05),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                "assets/images/home/dialog/hospital.svg",
                                color: redColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Emergency SOS',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                                Text(
                                  'Instant ambulance & paramedic\ndispatch',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () => handleEmergencyCall(context),
                    child: Container(
                      width: 316.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: redColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: -4,
                            color: redColor.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Call Ambulance Now",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- HOSPITALS NEARBY SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hospitals Nearby',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NearbyHospitalsView(),
                    ),
                  ),
                  child: Text(
                    'See All',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0063F7),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 🔥 HOSPITAL BLOC BUILDER
            BlocBuilder<HospitalBloc, HospitalState>(
              builder: (context, state) {
                if (state is HospitalLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HospitalError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is HospitalLoaded) {
                  if (state.hospitals.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Text(
                          "No nearby hospitals found.",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  }

                  // Only show up to 3 hospitals for the preview
                  final int displayCount = state.hospitals.length > 3
                      ? 3
                      : state.hospitals.length;

                  return ListView.separated(
                    shrinkWrap: true, // Required inside SingleChildScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable inner scroll
                    padding: EdgeInsets.zero,
                    itemCount: displayCount,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      return _buildHospitalCard(state.hospitals[index]);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 40.h),

            // --- DIAGNOSTIC LABS SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diagnostic Labs',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to See All Diagnostics
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0063F7),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // DIAGNOSTIC BLOC BUILDER
            BlocBuilder<DiagonosticBloc, DiagonosticState>(
              builder: (context, state) {
                if (state is DiagonosticLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DiagonosticListFetched) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: state.diagonosticListModel.length > 3
                        ? 3
                        : state.diagonosticListModel.length,
                    itemBuilder: (context, index) {
                      return DigonissiNearbyTie(
                        diagonosticList: state.diagonosticListModel[index],
                      );
                    },
                  );
                } else if (state is DiagonosticFalied) {
                  return const Center(child: Text("Failed to fetch"));
                }
                return Container();
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // 🔥 HOSPITAL CARD WIDGET UI
  Widget _buildHospitalCard(NearbyHospitalModel hospital) {
    String departments =
        hospital.specialties?.join(', ') ?? 'General Medical Center';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Container(
                  height: 140.h,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child:
                      hospital.imageUrl != null && hospital.imageUrl!.isNotEmpty
                      ? Image.network(hospital.imageUrl!, fit: BoxFit.cover)
                      : const Icon(
                          Icons.local_hospital,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              // Rating Badge (Top Right)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color(0xFFF59E0B),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${hospital.rating ?? 0.0}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Distance Badge (Bottom Left)
              Positioned(
                bottom: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        hospital.distance ?? "0 km",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Details Padding
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital.name ?? "Unknown Hospital",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  departments,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF6B7280),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: (hospital.isOpen24_7 ?? false)
                            ? const Color(0xFF10B981)
                            : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      (hospital.isOpen24_7 ?? false) ? "Open 24/7" : "Closed",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: (hospital.isOpen24_7 ?? false)
                            ? const Color(0xFF10B981)
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
