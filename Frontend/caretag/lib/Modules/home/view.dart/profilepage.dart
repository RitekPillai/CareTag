import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/home/widgets/profilePageHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    Profilemodel? profilemodel = Hive.box<Profilemodel>(
      'profile_records',
    ).get('profile_record');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 137,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xffFFF4BD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Quick Summary",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: 370.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff5EACFF), Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),

                      Center(
                        child: Text(
                          "Profile",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 122.h,
                        width: 119.w,
                        child: CircleAvatar(
                          maxRadius: 25.r,

                          backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          profilemodel!.fullName,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 5),
                        child: Text(
                          profilemodel!.careTagId,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                infoTitle(
                  "assets/images/profilePage/done.svg",
                  "10",
                  "Appointments\nDone",
                  185,
                ),
                SizedBox(width: 10.w),
                infoTitle(
                  "assets/images/profilePage/group.svg",
                  "79",
                  "Health Score",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                infoTitle(
                  "assets/images/profilePage/done.svg",
                  "23",
                  " Active \n  Records",
                ),
                SizedBox(width: 10.w),
                infoTitle(
                  "assets/images/profilePage/coins.svg",
                  "2000",
                  "CareTag\nCoins",
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  accountSettingSection(),
                  earningUsageSection(),
                  supportHelpSection(),
                  appLeagalSection(),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xffE1151B),
                      ),
                      fixedSize: WidgetStatePropertyAll(Size(291, 39)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(200),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Log Out",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
