import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/records_module/view/pages/doctor_prescription_page.dart';
import 'package:caretag/Modules/records_module/view/pages/record_home_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  String seletedOption = "Home";

  @override
  Widget build(BuildContext context) {
    const String imagePath = "assets/images/records";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment(1, 2),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("assets/images/records/Ellipse 94.svg"),
                  SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 70.w),
                                child: Text(
                                  "Records",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SvgPicture.asset("$imagePath/heart.svg"),

                            SizedBox(width: 11.72.w),
                            SvgPicture.asset("$imagePath/bell.svg"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              customSearchBar(),
            ],
          ),
          SizedBox(height: 30.w),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 15.w),

                titleStyleWidget("Home"),
                SizedBox(width: 21.w),
                Container(
                  width: 0,
                  height: 20.h,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.75, color: Colors.black),
                  ),
                ),
                SizedBox(width: 21.w),

                titleStyleWidget("Doctor\nPrescription"),
                SizedBox(width: 21.w),

                titleStyleWidget("Diagnostic\nReports"),
                SizedBox(width: 21.w),

                titleStyleWidget("Vaccination\nReports"),
                SizedBox(width: 21.w),
                titleStyleWidget("Medical\nHistory"),
                SizedBox(width: 21.w),
                titleStyleWidget("Bills\nInvoices"),
                SizedBox(width: 21.w),
                titleStyleWidget("Insurance Policy\n& Claims"),
                SizedBox(width: 21.w),
                titleStyleWidget("Health\nCertificates"),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: returnPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget returnPage() {
    switch (seletedOption) {
      case "Home":
        return RecordHomePage();
      case "Doctor\nPrescription":
        context.read<PatientBloc>().add(GetAllPrescription());
        return DoctorPrescriptionPage();
      default:
        return Container();
    }
  }

  Widget titleStyleWidget(String name) {
    bool isSelected = name == seletedOption;
    return GestureDetector(
      onTap: () {
        setState(() {
          seletedOption = name;
        });
      },
      child: Text(
        name,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: isSelected ? AppColor.lightBlueTextColor2 : Colors.black,
        ),
      ),
    );
  }
}
