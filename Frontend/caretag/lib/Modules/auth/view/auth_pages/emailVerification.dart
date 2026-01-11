// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_intro_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';

class Emailverification extends StatefulWidget {
  final String email;
  const Emailverification({super.key, required this.email});

  @override
  State<Emailverification> createState() => _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      context.read<AuthBloc>().add(AuthEmailVerification(email: widget.email));
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpCOmpleted) {
            _timer.cancel();

            final paitentBloc = context.read<PatientBloc>();

            Navigator.pushReplacement(
              context,
              customRoute(RegistrationIntroPage(), paitentBloc),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email Verification",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: AppColor.lightBlueTextColor2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
