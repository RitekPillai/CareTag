import 'package:caretag/Modules/auth/data/auth/forgot_password_request.dart';
import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_controller.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthCompleted) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => OtpPage()),
            // );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    debugPrint("Going to the help Page");
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Help?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                    bottom: 20,
                  ),
                  child: Text(
                    "Forgot your password?",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Don’t worry, we’ll help you reset it securely.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.lightBlueTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter your registered email address \n we’ll send you a code to reset your \n password.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),

                customTextFiled("Email address", "Email address", email),

                const SizedBox(height: 100),

                customElevatedButton(58, 253, "Send", 24, FontWeight.w700, () {
                  context.read<AuthBloc>().add(
                    AuthForgotPassword(
                      req: ForgotPasswordRequest(email: email.text),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
