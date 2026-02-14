import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  onPressed: () {},
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
              padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
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
            SizedBox(
              width: 299,
              child: Divider(
                thickness: 0.3,
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
            ),

            detailsTile(title),
          ],
        ),
      ),
    ),
  );
}

Widget detailsTile(String title) {
  switch (title) {
    case "Personal Details":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Name:", "Rylan Chettiar"),
          dataTile("Date of Birth:", "16/06/2005"),
          dataTile(
            "Permanent Home Address:",
            "B-102 Asmi,intage, Archana CHS, Industrial Colony, Behind Vipul Jewellers M.G. Road, Goregaon West, Mumbai.",
          ),
        ],
      );
    case "Basic Medical Info":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Blood Group:", "O +ve"),
          dataTile("Allergies:", "Peanuts, Oranges"),
          dataTile("Chronic Conditions:", "Diabetes "),
          dataTile("Past Surgeries:", "Heart, Stone "),
          dataTile("Drug Reactions or Intolerances:", "Crocin"),
          dataTile("Special Conditions:", "No"),
          dataTile("Genetic Health Conditions:", "No"),
        ],
      );
    case "Emergency Contact Details":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Name:", " Abhishek Pillai"),
          dataTile("Contact Number: ", "+91 97692 83125"),
        ],
      );
    case "Insurance Details":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Provider:", "Star Health"),
          dataTile("Insurance\nNumber:", "P/1234567/01/2025 /001"),
          dataTile("Insurance Type:", "Life "),
          dataTile("Expiry Date:", "29/12/2034"),
        ],
      );

    case "Preferences":
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataTile("Doctor:", "Dr. J.R.D. Shukla"),
          dataTile("Hospital:", "Hospital:"),
        ],
      );
    default:
      return Container();
  }
}

Widget dataTile(String heading, String value) {
  return Padding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 3),
    child: Text.rich(
      TextSpan(
        text: heading,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w300, fontSize: 16),
        children: [
          TextSpan(
            text: value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: AppColor.lightBlueTextColor2,
            ),
          ),
        ],
      ),
    ),
  );
}
