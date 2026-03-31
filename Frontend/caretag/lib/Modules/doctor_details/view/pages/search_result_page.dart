import 'package:caretag/Modules/doctor_details/model/search_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart'
    hide SearchLoaded;
import 'package:caretag/Modules/doctor_details/model_view/searchbloc/search_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/pages/doctor_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultsPage extends StatelessWidget {
  final String queryTitle; // To show in the AppBar (e.g., "Cardiology")

  const SearchResultsPage({Key? key, required this.queryTitle})
    : super(key: key);

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
          queryTitle,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      // 🔥 CHANGED TO SearchBloc and SearchState
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2563EB)),
            );
          } else if (state is SearchError) {
            return Center(
              child: Text(
                "Error: ${state.message}", // Extracts message from your SearchError state
                style: GoogleFonts.inter(color: Colors.red),
              ),
            );
          } else if (state is SearchLoaded) {
            if (state.doctors.isEmpty) {
              return Center(
                child: Text(
                  "No doctors found for '$queryTitle'.",
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 16.sp),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              itemCount: state.doctors.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];
                return _buildDoctorCard(context, doctor);
              },
            );
          }

          // Fallback initial state
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, SearchDoctorModel doctor) {
    final experience = "${doctor.yearsOfExperience ?? 0} Yrs";

    return GestureDetector(
      onTap: () {
        // 1. Ensure we have an ID before navigating
        if (doctor.id != null) {
          // 2. Tell the DoctorDetailBloc to fetch this specific doctor's info
          context.read<DoctorDetailBloc>().add(
            GetMyDoctorDetails(id: doctor.id!),
          );

          // 3. Navigate to the Detail Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DoctorDetailPage()),
          );
        } else {
          // Fallback just in case the backend returns a null ID
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Doctor ID is missing')),
          );
        }
      },
      child: Container(
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
            // --- PROFILE IMAGE ---
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
                image: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(doctor.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: doctor.imageUrl == null || doctor.imageUrl!.isEmpty
                  ? Icon(Icons.person, color: Colors.grey.shade400, size: 32.sp)
                  : null,
            ),
            SizedBox(width: 16.w),

            // --- DOCTOR DETAILS ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.fullName ?? "Unknown Doctor",
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

                      // Experience Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF), // Light blue bg
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.work_outline,
                              color: const Color(0xFF2563EB),
                              size: 14.sp,
                            ), // Blue icon
                            SizedBox(width: 4.w),
                            Text(
                              experience,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(
                                  0xFF1E3A8A,
                                ), // Dark blue text
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Specialty
                  Text(
                    doctor.specialization ?? "Specialty not listed",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // Location/Clinic
                  Row(
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          doctor.clinicName ?? 'Unknown Clinic',
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
      ),
    );
  }
}
