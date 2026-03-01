// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';

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
    const Color textColor = Color(0xff0F172A);
    const Color greyTextColor = Color(0xff475569);
    const Color blueCotatinerColor = Color.fromRGBO(43, 140, 238, 0.1);
    const Color blueContainerBorderColor = Color.fromRGBO(43, 140, 238, 0.2);
    const Color CircleProgressIndicatorColor = Color(0xff2B8CEE);

    Future<void> openMailApp() async {
      await LaunchApp.openApp(
        androidPackageName: 'com.google.android.gm',
        iosUrlScheme: 'googlegmail://',
        appStoreLink:
            'itms-apps://itunes.apple.com/app/apple-store/id422689480',
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if (state is SignUpCOmpleted) {
          //   _timer.cancel();

          //   final paitentBloc = context.read<PatientBloc>();

          //   Navigator.pushReplacement(
          //     context,
          //     customRoute(RegistrationIntroPage(), paitentBloc),
          //   );
          // }
        },
        child: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset("assets/images/records/Ellipse 94.svg"),
                Positioned(
                  left: 120.w,
                  top: 90.w,
                  child: Text(
                    "Verify Email",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 24.w,
                    ),
                  ),
                ),
              ],
            ),

            Image.asset("assets/images/auth/email.png"),
            SizedBox(height: 60.h),
            Text(
              "Verify Your Email",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 32.sp,
                color: textColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "We’ve sent a verification link to",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: greyTextColor,
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Text.rich(
                TextSpan(
                  text: widget.email,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,

                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          ". Please check your inbox and click the link to activate your account.",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: 342.w,
              height: 78.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: blueCotatinerColor,
                border: Border.all(color: blueContainerBorderColor, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: 0,
                          color: AppColor.getShadowColor(0.05),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.6,
                          color: CircleProgressIndicatorColor,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Waiting for verification...",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: AppColor.darkishBlueTextColor,
                        ),
                      ),
                      Text(
                        "Check your inbox",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColor.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            customElevatedButton(
              48.h,
              342.w,
              "Open Email App",
              18.sp,
              FontWeight.w700,
              () {
                openMailApp();
              },
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Resend Email",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.lightBlueTextColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
