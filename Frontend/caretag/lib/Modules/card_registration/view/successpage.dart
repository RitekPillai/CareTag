// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/view_careTagCard_page.dart';
import 'package:caretag/Modules/card_registration/view/watchRegitrationPage.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Successpage extends StatelessWidget {
  String careTagId;
  Successpage({Key? key, required this.careTagId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          SizedBox(
            height: 200,
            child: Lottie.asset(
              "assets/videos/done.json",
              fit: BoxFit.fill,
              repeat: false,
            ),
          ),
          const SizedBox(height: 100),

          Center(
            child: Text(
              textAlign: TextAlign.center,
              "“Your CareTag Code Has Been Generated!”",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xff139235),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            "This code links you securely to your health profile. Use it to access medical records, check in at clinics, or share with healthcare providers.",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColor.lightBlueTextColor2,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Your CareTag ID is",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          Text(
            careTagId,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customElevatedButton(51, 133, "View ID", 20, FontWeight.bold, () {
                Navigator.push(
                  context,
                  customRoute(
                    ViewCaretagcardPage(),
                    context.read<PatientBloc>(),
                  ),
                );
              }),
              customElevatedButton(
                51,
                145,
                "Continue",
                20,
                FontWeight.bold,
                () {
                  Navigator.pushReplacement(
                    context,
                    customRoute(
                      Watchregitrationpage(),
                      context.read<PatientBloc>(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
