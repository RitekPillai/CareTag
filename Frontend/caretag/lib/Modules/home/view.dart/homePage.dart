import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/modelview/homePageService.dart';
import 'package:caretag/Modules/home/view.dart/mainscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> blueGradient = [Color(0xff5EACFF), Color(0xff0063F7)];
    List<Color> greenGradient = [Color(0xff4ADE80), Color(0xff16A34A)];
    List<Color> orangeGradient = [Color(0xffFDBA74), Color(0xffFF6800)];

    Color circleColor = Color.fromRGBO(20, 50, 78, 0.2);

    return Scaffold(
      body: BlocBuilder<PatientBloc, PatientBlocState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Failed) {
            return Center(child: Text("Failed to load profile data"));
          } else if (state is ProfileRecordFetched) {
            Profilemodel profilemodel = state.profilemodel;

            return Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(profilemodel.imageUrl),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${Homepageservice().getTime()}👋",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: Text(
                            profilemodel.fullName,

                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 100),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // showDialogBox(
                          //   Permissionrequestmodel(
                          //     docName: "Ritek Abhishek",
                          //     placeName: "Pillai Hospital",
                          //     publicKey: "6767",
                          //   ),
                          // );
                        },
                        child: SvgPicture.asset("assets/images/home/bell.svg"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectionTile(
                      "CareTag\nHome",
                      "Your Health Hub – Always Connected, Always Protected.",
                      "assets/images/home/careTag.png",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MainScreen(profilemodel: profilemodel),
                          ),
                        );
                      },
                      blueGradient,
                    ),
                    const SizedBox(width: 20),
                    selectionTile(
                      "CareTag\nPharmacy",
                      "Medicines Delivered Fast,\nWhen You Need Them Most.",
                      "assets/images/home/pharmacy.png",
                      () {},
                      greenGradient,
                      20,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 355,
                  height: 174,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    gradient: LinearGradient(
                      colors: orangeGradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            height: 300,
                            width: 100,
                            decoration: BoxDecoration(
                              color: circleColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(200, 200),
                                bottomLeft: Radius.elliptical(200, 200),
                                bottomRight: Radius.circular(42),
                                topRight: Radius.circular(42),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 29),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "CareTag\nMy Journey",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Track, Improve, Transform –\nYour Fitness Companion.",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/images/home/gym.png",
                                width: 160.w,
                                height: 120.h,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget selectionTile(
  String title,
  String description,
  String image,
  VoidCallback onTap,
  List<Color> color, [
  double height = 5,
]) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: color,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),

      width: 164,
      height: 255,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 10),
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 11,
            ),
          ),
          SizedBox(height: height),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset("assets/images/home/Ellipse 78.svg"),
              Image.asset(
                image,
                filterQuality: FilterQuality.high,
                width: 150,
                height: 114,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
