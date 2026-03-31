import 'package:caretag/Modules/doctor_details/model/near_by_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NearbyDoctorsWidget extends StatelessWidget {
  final List<NearbyDoctorModel> nearbyDoctors;

  const NearbyDoctorsWidget({Key? key, required this.nearbyDoctors})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Nearby Top Rated',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // List
        if (nearbyDoctors.isEmpty)
          Center(
            child: Text(
              "No nearby doctors found.",
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 16.sp),
            ),
          )
        else
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shrinkWrap: true, // Crucial for a ListView inside a Column
            physics:
                const NeverScrollableScrollPhysics(), // Disables inner scrolling
            itemCount: nearbyDoctors.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return _buildDoctorCard(nearbyDoctors[index]);
            },
          ),
      ],
    );
  }

  Widget _buildDoctorCard(NearbyDoctorModel doctor) {
    final ratingOrLinks = doctor.numLink?.toString() ?? "0";

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
              image: doctor.imgUrl != null && doctor.imgUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(doctor.imgUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: doctor.imgUrl == null || doctor.imgUrl!.isEmpty
                ? Icon(Icons.person, color: Colors.grey.shade400, size: 32.sp)
                : null,
          ),
          SizedBox(width: 16.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        doctor.docName ?? "Unknown Doctor",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF9C3),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_border_rounded,
                            color: const Color(0xFFEAB308),
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            ratingOrLinks,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF854D0E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  doctor.specialities ?? "Specialty not listed",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        "${doctor.distance ?? '0 km'} • ${doctor.clinicName ?? 'Unknown Clinic'}",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
