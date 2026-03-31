import 'package:caretag/Modules/Hospital/model/NearByHospitalModel.dart';
import 'package:caretag/Modules/Hospital/model_view/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// Import your HospitalBloc and NearbyHospitalModel here

class NearbyHospitalsView extends StatefulWidget {
  const NearbyHospitalsView({Key? key}) : super(key: key);

  @override
  State<NearbyHospitalsView> createState() => _NearbyHospitalsViewState();
}

class _NearbyHospitalsViewState extends State<NearbyHospitalsView> {
  @override
  void initState() {
    super.initState();
    context.read<HospitalBloc>().add(FetchNearbyHospitals());
  }

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
          'Nearby Hospitals',
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
          // Search Bar & Filter Icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search hospitals...',
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
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(Icons.tune, color: Colors.black),
                ),
              ],
            ),
          ),

          // List View
          Expanded(
            child: BlocBuilder<HospitalBloc, HospitalState>(
              builder: (context, state) {
                if (state is HospitalLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HospitalError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is HospitalLoaded) {
                  if (state.hospitals.isEmpty) {
                    return Center(
                      child: Text(
                        "No nearby hospitals found.",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280), // Slate grey
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    itemCount: state.hospitals.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemBuilder: (context, index) {
                      return _buildHospitalCard(state.hospitals[index]);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

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
                  height: 160.h,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: hospital.imageUrl != null
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
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  departments,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF6B7280),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
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
                        fontSize: 14.sp,
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
