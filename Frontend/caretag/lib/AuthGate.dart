import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/auth/view/Intro_page&permisson_page/introPage1.dart';
import 'package:caretag/Modules/auth/view/auth_pages/oauthPage.dart';
import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_intro_page.dart';
import 'package:caretag/Modules/home/view.dart/caretag_homepage.dart';
import 'package:caretag/Modules/home/view.dart/homePage.dart';
import 'package:caretag/Modules/home/view.dart/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (BuildContext context, AuthState state) {
        if (state is NewUser) {
          return const Intropage1();
        } else if (state is Authenticated) {
          context.read<PatientBloc>().add(GetProfileData());

          return const Homepage();
        } else if (state is RegistrationPage) {
          return const RegistrationIntroPage();
        } else if (state is LoginScreen) {
          return Oauthpage();
        }

        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // You could put your Medical Logo here
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("CareTag: Securing your Health..."),
              ],
            ),
          ),
        );
      },
    );
  }
}
