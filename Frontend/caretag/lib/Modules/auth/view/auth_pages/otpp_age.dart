import 'dart:async';

import 'package:caretag/Modules/auth/data/model/otpVerifyRequest.dart';
import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_intro_page.dart';
import 'package:caretag/Modules/home/view.dart/homePage.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  int _start = 32;
  late Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();

    super.initState();
  }

  void startTimer() {
    _start = 32;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    for (var con in controllers) {
      con.dispose();
    }
    for (var fn in focusNodes) {
      fn.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20),
              child: Text(
                "Enter the OTP?",
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
              "We’ve sent a 6-digit code to your registered \n email.\n\n\nEnter the code below to\nreset your password.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return otpTextFiled(context, index, controllers, focusNodes);
              }),
            ),
            const SizedBox(height: 60),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Didn’t receive the code?",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _start > 0
                    ? Text(
                        "Resend the OTP in ${_start}s",
                        style: GoogleFonts.poppins(
                          color: Color(0xffFF5257),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          debugPrint("Generating the otp again.....");
                        },
                        child: Text(
                          "Click Here",
                          style: GoogleFonts.poppins(
                            color: Color(0xffFF5257),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 20),

            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  Navigator.pushReplacement(
                    context,
                    customRoute(Homepage(), context.read<AuthBloc>()),
                  );
                }
                if (state is LoginCompleted) {
                  Navigator.pushReplacement(
                    context,
                    customRoute(
                      RegistrationIntroPage(),
                      context.read<PatientBloc>(),
                    ),
                  );
                }
              },
              child: customElevatedButton(
                58,
                253,
                "Verify",
                24,
                FontWeight.w700,
                () {
                  String otpcode = "";
                  for (var code in controllers) {
                    otpcode += code.text;
                  }
                  context.read<AuthBloc>().add(
                    AuthLoginOtpVerify(
                      req: OtpVerifyModel(
                        email: widget.email,
                        otpCode: otpcode,
                      ),
                    ),
                  );

                  debugPrint("OTP CoDE : $otpcode");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget otpTextFiled(
  BuildContext context,
  int index,
  List<TextEditingController> controllers,
  List<FocusNode> focusNodes,
) {
  final FocusNode currentFocusNode = focusNodes[index];
  final TextEditingController currentController = controllers[index];

  return KeyboardListener(
    focusNode: FocusNode(),
    onKeyEvent: (value) {
      if (value is KeyDownEvent) {
        if (value.logicalKey == LogicalKeyboardKey.backspace &&
            currentController.text.isEmpty &&
            index > 0) {
          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          controllers[index - 1].clear();
        }
      }
    },
    child: Stack(
      children: [
        Container(
          width: 43,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xff346EE3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.black),
          ),
        ),
        Container(
          width: 43,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.black),
          ),
        ),
        SizedBox(
          width: 44,
          height: 70,
          child: TextField(
            controller: currentController,
            focusNode: currentFocusNode,
            onChanged: (value) {
              if (value.length == 1 && index < 5) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.length == 1 && index == 5) {
                FocusScope.of(context).unfocus();
              }
            },
            showCursor: true,
            maxLength: 1,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
