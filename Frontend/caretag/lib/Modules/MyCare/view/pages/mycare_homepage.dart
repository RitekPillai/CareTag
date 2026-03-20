import 'package:caretag/Modules/Invoice/model_view/bloc/invoice_bloc.dart';
import 'package:caretag/Modules/MyCare/view/pages/careService.dart';
import 'package:caretag/Modules/MyCare/view/pages/caretag_page.dart';
import 'package:caretag/Modules/MyCare/view/pages/insurance_page.dart';
import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart';
import 'package:caretag/Modules/doctor_details/view/pages/doctors_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MycarePage extends StatefulWidget {
  const MycarePage({super.key});

  @override
  State<MycarePage> createState() => _MyCarePagState();
}

class _MyCarePagState extends State<MycarePage> {
  String seletedOption = "Home";
  @override
  Widget build(BuildContext context) {
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
                  Positioned(
                    left: 150.w,
                    child: Text(
                      "My Care",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
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

                titleStyleWidget("caretag"),
                SizedBox(width: 21.w),

                titleStyleWidget("Doctors"),
                SizedBox(width: 21.w),

                titleStyleWidget("Care\nServices"),
                SizedBox(width: 21.w),
                titleStyleWidget("Insurance"),
                SizedBox(width: 21.w),
                titleStyleWidget("Timeline"),
                SizedBox(width: 21.w),
                SizedBox(width: 21.w),
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
        return Center(child: Text("home"));
      case "caretag":
        return CaretagPage();
      case "Doctors":
        context.read<DoctorDetailBloc>().add(GetMyDoctor());
        return DoctorsPage();
      case "Insurance":
        return InsurancePage();
      case "Care\nServices":
        return MyCareCareServicesContent();
      default:
        return Center(child: Text("ata"));
    }
  }

  Widget titleStyleWidget(String name) {
    bool isSelected = name == seletedOption;

    return GestureDetector(
      onTap: () {
        setState(() {
          seletedOption = name;
          if (name == "Bills\nInvoices") {
            context.read<InvoiceBloc>().add(GetInvoiceList());
          }
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
