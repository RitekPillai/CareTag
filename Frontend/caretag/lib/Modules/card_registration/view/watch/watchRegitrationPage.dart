import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/model_view/service/bluetoothService.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custom_divider.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/helpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Watchregitrationpage extends StatefulWidget {
  const Watchregitrationpage({super.key});

  @override
  State<Watchregitrationpage> createState() => _WatchregitrationpageState();
}

class _WatchregitrationpageState extends State<Watchregitrationpage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/watch.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Bluetoothservice bluetoothService = Bluetoothservice();

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            help(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Link Your Smartwatch",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Connect your device to monitor heart rate, activity, and vital stats in real time",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColor.lightBlueTextColor2,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            Container(
              height: 482,
              width: 393,
              padding: const EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(238, 245, 255, 0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Select from the devices given below",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Logos("googlelogo.svg", 60, 100),
                      Logos("applelogo.svg", 25, 100),
                      Logos("boat.svg", 20, 100),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Logos("samsung.svg", 80, 100),
                      Logos("fire-boltt.png", 100, 100),
                      Logos("Noise logo.svg", 80, 100),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Logos("fastrack.svg", 65, 100),
                      Logos("realme.svg", 80, 100),
                      Logos("other", 80, 100),
                    ],
                  ),
                  const SizedBox(height: 30),
                  customElevatedButton(
                    60,
                    180,
                    "Start Pairing",
                    20,
                    FontWeight.w500,
                    () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Watchpairing()),
                      // );

                      bluetoothService.handlePermission(
                        context,
                        context.read<PatientBloc>(),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  customDivider("or", 120),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have a smartwatch?",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          //  Navigator.pushReplacement(context, customRoute(sub, blocInstance))
                        },
                        child: Text(
                          "Skip For now",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
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

Widget Logos(String imagePath, double height, double width) {
  return Container(
    width: 110,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Colors.grey.shade100],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      border: Border.all(color: Colors.white, width: 0.5),
    ),
    child: Center(
      child: imagePath == "other"
          ? Text(
              "Other",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: imagePath == "fire-boltt.png"
                  ? Image.asset(
                      "assets/images/watch/$imagePath",
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      "assets/images/watch/$imagePath",
                      fit: BoxFit.cover,
                      height: height,
                      width: width,
                    ),
            ),
    ),
  );
}
