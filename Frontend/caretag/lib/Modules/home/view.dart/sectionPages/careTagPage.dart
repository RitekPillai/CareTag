import 'dart:developer';

import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/view.dart/emergencypage.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/careTagCard.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/heartbeatcard.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/medinceremindertile.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/stepcount_card.dart';
import 'package:caretag/Modules/home/widgets/caretag_homepage_helpers.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Caretagpage extends StatelessWidget {
  final String name;
  final String bloodType;

  const Caretagpage({super.key, required this.name, required this.bloodType});

  @override
  Widget build(BuildContext context) {
    final helper = CaretagHomepageHelpers();
    Color textColor = Color(0xff0063F7);
    return Column(
      children: [
        const SizedBox(height: 10),
        customSearchBar(),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "CareTag Card",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View Card",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 174,
          width: 349,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: AlignmentGeometry.topCenter,
              colors: AppColor.gradientButtonColor,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Text(
                        "Blood Type $bloodType",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  SvgPicture.asset(
                    "assets/images/home/shiled.svg",
                    width: 65,
                    height: 68,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        final box = Hive.box('decrypted_records');
                        final cachedData = box.get('latest_emergency_profile');

                        if (cachedData != null) {
                          log(
                            "Using local vault data. No network request sent.",
                          );
                          return Emergencypage();
                        }

                        context.read<PatientBloc>().add(GetPatientRecord());

                        return Emergencypage();
                      },
                    ),
                  );
                },
                child: Container(
                  width: 291,
                  height: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Tap to show full emergency info",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                helper.adTile(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quick Services",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff0063F7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                helper.servicesList(),

                Caretagcard(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Text(
                        "Your Health Today",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Container(
                      width: 83,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                        color: Color(0xffF1F5F9),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Updates Live",
                        style: GoogleFonts.poppins(
                          color: Color(0xff717171),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [StepcountCard(), Heartbeatcard()],
                ),

                const SizedBox(height: 50),
                Medinceremindertile(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
