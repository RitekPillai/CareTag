import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:caretag/widgets/custom_divider.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/help_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class RegistrationIntroPage extends StatefulWidget {
  const RegistrationIntroPage({super.key});

  @override
  State<RegistrationIntroPage> createState() => _RegistrationIntroPageState();
}

class _RegistrationIntroPageState extends State<RegistrationIntroPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/videos/rfid.mp4");
    _controller.initialize();
    _controller.setLooping(true);
    _controller.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paitentBloc = context.read<PatientBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            help(),

            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Get Started with Your \nCareTag RFID",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  color: AppColor.darkishBlue,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              "Choose an option to connect your CareTag \nprofile with an RFID tag for secure access to \nyour medical records.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.darkishBlue2,
              ),
            ),
            SizedBox(
              width: 365,
              height: 325,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            Container(
              width: 393,
              height: 301,
              decoration: BoxDecoration(
                color: Color.fromRGBO(238, 245, 255, 0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Generate a new CareTag ID if you don’t \nhave a card yet.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: AppColor.lightBlueTextColor2,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),

                  customElevatedButton(
                    57,
                    167,
                    "Create",
                    24,
                    FontWeight.w700,
                    () {
                      Navigator.pushReplacement(
                        context,

                        customRoute(RegistrationPage(), paitentBloc),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  customDivider("or", 133.7),
                  const SizedBox(height: 15),
                  Text(
                    "Scan or enter your existing RFID to connect",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  customElevatedButton(
                    54,
                    167,
                    "Link",
                    24,
                    FontWeight.w700,
                    () {},
                    33,
                    [Color(0xff254799), Color(0xff1F2937)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
