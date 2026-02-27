import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/view.dart/homePage.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/subscription/done.png",
              width: 253,
              height: 253,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            "Your order has been placed successfully",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              textAlign: TextAlign.center,
              "You’ll receive a confirmation email shortly. Delivery in 4–7 working days",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(height: 25),
          customElevatedButton(48, 343, "Next", 20, FontWeight.bold, () {
            final box = Hive.box<Profilemodel>('profile_records');
            final profileData = box.get('profile_record');

            if (profileData != null) {
              Navigator.pushReplacement(
                context,
                customRoute(Homepage(), context.read<PatientBloc>()),
              );
            } else {
              context.read<PatientBloc>().add(GetProfileData());
              Navigator.pushReplacement(
                context,
                customRoute(Homepage(), context.read<PatientBloc>()),
              );
            }
          }, 12),
        ],
      ),
    );
  }
}
