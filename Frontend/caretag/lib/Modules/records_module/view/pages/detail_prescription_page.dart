import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/widgets/profilePageHelpers.dart';
import 'package:caretag/Modules/records_module/model/prescription_detail_model.dart';
import 'package:caretag/Modules/records_module/view/widgets/diagonsis_container_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/medicine_container_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/prescription_conatiner_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPrescriptionPage extends StatelessWidget {
  const DetailPrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xff0F172A);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: BlocBuilder<PatientBloc, PatientBlocState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PrescriptionDetailFetched) {
              PrescriptionDetail prescriptionDetail = state.prescriptionDetail;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300.h,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            width: double.infinity,
                            height: 290.h,

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff3B81F6).withAlpha(100),
                                  Color(0xff3B81F6),
                                  Color(0xff3B81F6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70.w,
                          left: 60.0.w,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<PatientBloc>().add(
                                        GetAllPrescription(),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                      "assets/images/records/arrow.svg",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 39.w),
                                  Text(
                                    "Medications",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 125.h,
                          left: 20.w,
                          child: PrescriptionConatinerTile(
                            doctorName: prescriptionDetail.doctorName!,
                            specialization: prescriptionDetail.specialization!,
                            hosptialName: prescriptionDetail.hospitalName!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  DiagonsisContainerTile(
                    diagonsis: prescriptionDetail.diagnosis!,
                  ),

                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/records/prescription/medication.svg",
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Prescribed Medicines",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => MedicineContainerTile(
                      medications: prescriptionDetail.medications![index],
                    ),
                    itemCount: prescriptionDetail.medications!.length,
                  ),
                  SizedBox(height: 24.h),

                  SizedBox(height: 16.h),
                ],
              );
            } else {
              return Center(child: Text("No asd asd"));
            }
          },
        ),
      ),
    );
  }
}
