// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/view/registration/successpage.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/helpPage.dart';

class RegistrationLoadingScreen extends StatefulWidget {
  final Medicarecordmodel medicalDetails;
  const RegistrationLoadingScreen({super.key, required this.medicalDetails});

  @override
  State<RegistrationLoadingScreen> createState() =>
      _RegistrationLoadingScreenState();
}

class _RegistrationLoadingScreenState extends State<RegistrationLoadingScreen> {
  late Stream<int> _tipStream;
  @override
  void initState() {
    // TODO: implement initState
    _tipStream = Stream.periodic(
      const Duration(seconds: 3),
      (count) => count % 3,
    );

    super.initState();
  }

  void startrequest() {
    var timerCount = 3;
    Timer.periodic(Duration(seconds: timerCount), (timer) {
      debugPrint(timerCount.toString());
      timerCount--;

      if (timerCount == 0) {
        context.read<PatientBloc>().add(
          PatientRegistration(medicalRecord: widget.medicalDetails),
        );
        debugPrint("requested");

        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> healthTips = [
      "Drinking enough water can improve your focus and energy levels.",
      "A 10-minute walk after meals can help regulate blood sugar.",
      "Consistent sleep schedules improve long-term heart health.",
    ];
    startrequest();
    return BlocListener<PatientBloc, PatientBlocState>(
      listener: (context, state) {
        if (state is Success) {
          Navigator.pushReplacement(
            context,
            customRoute(
              Successpage(careTagId: state.careTagId),
              context.read<PatientBloc>(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            help(),
            Text(
              textAlign: TextAlign.center,
              "Create Your CareTag RFID",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w900,
                fontSize: 32,
                color: AppColor.darkishBlue,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              textAlign: TextAlign.center,
              "We are generating a 12 digit CTID for your CareTag RFID",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.lightBlueTextColor,
              ),
            ),
            Lottie.asset("assets/videos/loading.json", height: 210, width: 301),

            Text(
              textAlign: TextAlign.center,
              "Every CareTag ID is unique — hold tight while we create yours.",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff1E346A),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Till then read some health tips below",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xffC73232),
              ),
            ),
            const SizedBox(height: 40),
            StreamBuilder<int>(
              initialData: 0,

              stream: _tipStream,
              builder: (context, snapshot) {
                int index = snapshot.data ?? 0;
                return newContainer(healthTips[index], index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget newContainer(String message, int value) {
  return Container(
    height: 107,
    width: 299,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(23),
      border: Border.all(color: Colors.black, width: 1),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.fromRGBO(168, 223, 241, 0.23), Color(0xff45A1F4)],
      ),
    ),
    child: Center(
      child: AnimatedSwitcher(
        duration: Duration(microseconds: 500),
        child: Text(
          key: ValueKey(value),
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
