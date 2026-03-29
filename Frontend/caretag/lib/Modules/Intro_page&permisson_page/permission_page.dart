import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:caretag/Modules/auth/view/auth_pages/oauthPage.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  int index = 0;
  double backFontSize = 20;
  double acceptFontSize = 20;

  void _onPressBack() {
    setState(() {
      if (index == 1) {
        index = 0;
        backFontSize = 18;
        acceptFontSize = 20;
      }

      debugPrint("CurrentIndex:$index");
    });
  }

  void _onPressAccept() {
    final authBloc = context.read<AuthBloc>();
    setState(() {
      index++;
      acceptFontSize = 18;
      backFontSize = 20;
      if (index == 2) {
        Navigator.pushReplacement(context, customRoute(Oauthpage(), authBloc));
      }

      debugPrint("CurrentIndex:$index");
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    debugPrint("Current Index:$index");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              textAlign: TextAlign.start,
              "Let’s get started",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 36.sp,
                color: AppColor.darkishBlue,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 26.w),
            child: Text(
              textAlign: TextAlign.start,
              "We need a few permissions before we continue",
              style: GoogleFonts.poppins(
                color: AppColor.lightBlueTextColor2,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),

            child: indexpages(index),
          ),
          SizedBox(height: 16.h),
          Center(
            child: Container(
              width: 103,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(103),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: "${index == 2 ? 2 : index + 1}",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "/",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: "2",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.center,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [
                      Color.fromRGBO(107, 114, 128, 1),
                      Color.fromRGBO(22, 23, 26, 0.5),
                    ],
                  ),
                ),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: _onPressBack,
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      shadowColor: WidgetStatePropertyAll(Colors.transparent),
                    ),
                    child: Text(
                      "Back",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: backFontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: index == 0 ? 130 : 125,
                height: 42,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: AppColor.gradientButtonColor,
                  ),
                ),

                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      shadowColor: WidgetStatePropertyAll(Colors.transparent),
                    ),
                    onPressed: _onPressAccept,
                    child: Text(
                      "Accept",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: acceptFontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget indexpages(int index) {
  if (index == 0) {
    return Column(
      key: ValueKey(0),
      children: [
        permissonsTile(
          "assets/images/permission/email.svg",
          "SMS",
          "CareTag sync SMS to verify your device \nand set up various features ",
        ),
        permissonsTile(
          "assets/images/permission/folder.svg",
          "Medical Record Access",
          "Allow CareTag to securely access and \ndisplay your medical records.",
        ),
        permissonsTile(
          "assets/images/permission/lock.svg",
          "RFID Integration",
          "Grant permission to scan and link your \nRFID card to your health profile.",
        ),
        permissonsTile(
          "assets/images/permission/camera.svg",
          "Camera Access",
          "CareTag needs access to your camera \nto scan RFID tags or prescriptions.",
        ),
      ],
    );
  } else if (index == 1) {
    return Column(
      key: ValueKey(1),
      children: [
        permissonsTile(
          "assets/images/permission/loc.svg",
          "Location Access",
          "Enable location to find nearby hospitals \nand emergency services.",
        ),
        permissonsTile(
          "assets/images/permission/medical.svg",
          "Doctor Access & Consent",
          "Allow your doctor to view selected \nhealth data with your permission.",
        ),
        permissonsTile(
          "assets/images/permission/call.svg",
          "Emergency Contact",
          "Give access to your contact directory \ndetails for quick help when needed.",
        ),
        permissonsTile(
          "assets/images/permission/shield.svg",
          "Privacy & Security",
          "Your data is encrypted and never \nshared without your consent.",
        ),
      ],
    );
  } else {
    return Container();
  }
}

Widget permissonsTile(String icon, String title, String discription) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon, width: 30, height: 30),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColor.darkishBlue,
              ),
            ),
            SizedBox(
              height: 55.h,
              width: 336.w,
              child: Text(
                discription,
                maxLines: 3,

                overflow: TextOverflow.clip,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,

                  fontSize: 16,
                  color: AppColor.darkishBlue,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
