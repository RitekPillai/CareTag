import 'dart:convert';
import 'dart:developer';

import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/utils/hiveService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Emergencypage extends StatelessWidget {
  const Emergencypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F1F3),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SvgPicture.asset("assets/images/home/emergency/bg.svg"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Emergency Profile",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        textAlign: TextAlign.center,
                        "Quick access to life-saving details in case of\nemergency.",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 341,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      containerTile(
                        "personalDetails.svg",
                        "Personal Details",
                        "Identity details for medical and legal clarity.",
                        Color(0xffEFF6FF),
                      ),
                      containerTile(
                        "medInfo.svg",
                        "Basic Medical Info",
                        "Identify details for medical and legal clarity.",
                        Color(0xffFEF2F2),
                      ),
                      containerTile(
                        "contact.svg",
                        "Emergency Contact Details",
                        "Identify details of your emergency contact",
                        Color(0xffF0FDF4),
                      ),
                      containerTile(
                        "insurance.svg",
                        "Insurance Details",
                        "Identify details of insurance",
                        Color.fromRGBO(240, 180, 33, 0.15),
                      ),
                      containerTile(
                        "preference.svg",
                        "Preferences",
                        "Identify details of your prefermces",
                        Color.fromRGBO(191, 0, 3, 0.1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget containerTile(
  String imagename,
  String title,
  String description,
  Color conaitnercolor,
) {
  final String imagePath = "assets/images/home/emergency";

  return ValueListenableBuilder(
    valueListenable: Hive.box('decrypted_records').listenable(),
    builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: Container(
            width: 341,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 10,
                    bottom: 5,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: conaitnercolor,
                        ),
                        child: Center(
                          child: SvgPicture.asset("$imagePath/$imagename"),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text.rich(
                        TextSpan(
                          text: "$title\n",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: description,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 299.w,
                    child: Divider(
                      thickness: 0.3,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                  ),
                ),

                detailsTile(title),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget detailsTile(String title) {
  final hivebox = Hive.box('decrypted_records');
  final encrptedData = hivebox.get('latest_emergency_profile');
  log("Encrpted data:$encrptedData");
  if (encrptedData == null) {
    return BlocBuilder<PatientBloc, PatientBlocState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RecordFetched) {
          final record = state.medicalRecord;
          return dataUI(title, record);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  } else {
    try {
      final Map<String, dynamic> recordMap = jsonDecode(encrptedData as String);
      final record = Medicarecordmodel.fromJson(recordMap);
      return dataUI(title, record);
    } catch (e) {
      log("Hive Data Parsing Error: $e");
      return const SizedBox.shrink();
    }
  }
}

Widget dataUI(String title, Medicarecordmodel record) {
  Profilemodel? profilemodel = Hiveservice().getProfileData();
  String fullName = "";
  String bloodGroup = "";
  String dob = "";
  String address = "";

  if (profilemodel != null) {
    fullName = profilemodel.fullName;
    bloodGroup = profilemodel.bloodGroup;
    dob = profilemodel.dob;
    address = profilemodel.address;
  }
  switch (title) {
    case "Personal Details":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Name: ", fullName),
          dataTile("Date of Birth:", dob),
          dataTile("Permanent Home Address:", address),
          dataTile("Blood Group:", bloodGroup),
        ],
      );
    case "Basic Medical Info":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Allergies:", record.medicalDetails.allegries),
          dataTile(
            "Chronic Conditions:",
            record.medicalDetails.chronicConditions,
          ),
          dataTile("Past Surgeries:", record.medicalDetails.pastSurgeries),
          dataTile(
            "Drug Reactions or Intolerances:",
            record.medicalDetails.drugReactions,
          ),
          dataTile("Special Conditions:", record.medicalDetails.diagonoses),
          dataTile(
            "Genetic Health Conditions:",
            record.medicalDetails.hereditaryGenetic,
          ),
        ],
      );
    case "Emergency Contact Details":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Name:", record.emergencyDetails.name),
          dataTile("Contact Number: ", record.emergencyDetails.contact),
        ],
      );
    case "Insurance Details":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Provider:", record.insuranceDetails.provider),
          dataTile("Insurance\nNumber:", record.insuranceDetails.policyNumber),
          dataTile("Insurance Type:", "Life "),
          dataTile("Expiry Date:", "29/12/2034"),
        ],
      );

    case "Preferences":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Doctor:", record.medicalDetails.prefferedDoctor),
          dataTile("Hospital:", "Hospital:"),
        ],
      );
    default:
      return Container();
  }
}

Widget dataTile(String heading, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    child: SizedBox(
      width: double.infinity,
      child: Text.rich(
        TextSpan(
          text: "$heading ",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            color: Colors.black,
          ),

          children: [
            TextSpan(
              text: value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 16.sp,
                color: AppColor.lightBlueTextColor2,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
