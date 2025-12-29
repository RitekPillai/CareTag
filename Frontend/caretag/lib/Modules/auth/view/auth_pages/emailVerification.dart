import 'dart:async';

import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/card_registration/view/Registration_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Emailverification extends StatelessWidget {
  const Emailverification({super.key});

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer.periodic(Duration(seconds: 5), (timer) {
      context.read<AuthBloc>().add(AuthEmailVerification());
    });

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
            );
            timer.cancel();
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
